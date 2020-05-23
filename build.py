import glob
import os
import re
import shutil
import sys
import subprocess
from pathlib import Path

current_dir = os.path.dirname(os.path.realpath(__file__))
build_dir = os.path.join(current_dir, 'build')
install_dir = os.path.join(build_dir, 'install')

try:
    shutil.rmtree(build_dir)
except OSError:
    pass
os.makedirs(build_dir, exist_ok=True)

subprocess.run(['git', 'reset', '--hard', 'origin/release/v3.3'], cwd=os.path.join(current_dir, 'ESP8266_RTOS_SDK'))
subprocess.run(['git', 'reset', '--hard', 'origin/release/v3.3'], cwd=os.path.join(current_dir, 'ESP8266_RTOS_SDK'))

env = os.environ.copy()
python_dir = os.path.join(current_dir, 'venv', 'Scripts')
env['PATH'] = f'{python_dir};{env["PATH"]}'
env['IDF_PATH'] = os.path.join(current_dir, 'ESP8266_RTOS_SDK')

subprocess.run(['git', 'reset', '--hard', 'origin/release/v3.3'], cwd=os.path.join(current_dir, 'ESP8266_RTOS_SDK'))
subprocess.run(['git', 'submodule', 'update', '--init', '--recursive'], cwd=os.path.join(current_dir, 'ESP8266_RTOS_SDK'))

patches = glob.glob(os.path.join(current_dir, 'patches', '*.patch'))

def natural_sort_key(key):
    convert = lambda text: int(text) if text.isdigit() else text 
    return [convert(c) for c in re.split('([0-9]+)', key)]

patches.sort(key=natural_sort_key)

for patch in patches:
    with open(patch, 'rb') as file:
        patch_data = file.read()
    subprocess.run(['git', 'am', os.path.join(current_dir, 'patches', patch)], cwd=os.path.join(current_dir, 'ESP8266_RTOS_SDK'), input=patch_data)

subprocess.run(['cmake', '-G', 'Ninja', current_dir], cwd=build_dir, env=env)
subprocess.run(['ninja'], cwd=build_dir, env=env)

def safe_copy(src, dst):
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    shutil.copyfile(src, dst)

print('Copying files to installation directory...')

safe_copy(os.path.join(build_dir, 'bootloader', 'bootloader.bin'), os.path.join(install_dir, 'bin', 'bootloader.bin'))
safe_copy(os.path.join(current_dir, 'ESP8266_RTOS_SDK', 'components', 'esp8266', 'ld', 'esp8266.peripherals.ld'), os.path.join(install_dir, 'ld', 'esp8266.peripherals.ld'))
safe_copy(os.path.join(current_dir, 'ESP8266_RTOS_SDK', 'components', 'esp8266', 'ld', 'esp8266.rom.ld'), os.path.join(install_dir, 'ld', 'esp8266.rom.ld'))
safe_copy(os.path.join(build_dir, 'esp-idf', 'esp8266', 'esp8266_out.ld'), os.path.join(install_dir, 'ld', 'esp8266.ld'))
safe_copy(os.path.join(build_dir, 'esp-idf', 'esp8266', 'ld', 'esp8266.project.ld'), os.path.join(install_dir, 'ld', 'esp8266.project.ld'))
safe_copy(os.path.join(build_dir, 'config', 'sdkconfig.h'), os.path.join(install_dir, 'include', 'sdkconfig.h'))
safe_copy(os.path.join(current_dir, 'tools', 'analyze_map.py'), os.path.join(install_dir, 'tools', 'analyze_map.py'))
safe_copy(os.path.join(current_dir, 'tools', 'esptool.py'), os.path.join(install_dir, 'tools', 'esptool.py'))
safe_copy(os.path.join(current_dir, 'tools', 'flash.py'), os.path.join(install_dir, 'tools', 'flash.py'))
safe_copy(os.path.join(current_dir, 'tools', 'gen_esp32part.py'), os.path.join(install_dir, 'tools', 'gen_esp32part.py'))
safe_copy(os.path.join(current_dir, 'tools', 'idf_size.py'), os.path.join(install_dir, 'tools', 'idf_size.py'))
safe_copy(os.path.join(current_dir, 'tools', 'terminal.py'), os.path.join(install_dir, 'tools', 'terminal.py'))

for path in Path(os.path.join(build_dir, 'esp-idf')).rglob('*.a'):
    safe_copy(path, os.path.join(install_dir, 'lib', path.name))

for path in Path(os.path.join(current_dir, 'ESP8266_RTOS_SDK', 'components')).rglob('*.a'):
    safe_copy(path, os.path.join(install_dir, 'lib', path.name))

for path in Path(os.path.join(current_dir, 'ESP8266_RTOS_SDK', 'components')).rglob('*.h'):
    safe_copy(path, os.path.join(install_dir, 'include', os.path.relpath(path, os.path.join(current_dir, 'ESP8266_RTOS_SDK', 'components'))))

print('Done.')
