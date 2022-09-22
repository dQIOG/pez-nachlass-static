import glob
import os
import shutil

TARGET_DIR = './data/editions'

os.makedirs('./data/editions', exist_ok=True)

files = sorted(glob.glob('./pez-editions-legacy-master/102_derived_tei/102_07_bequest/msDesc/*/*.xml'))
print(len(files))


for x in files:
    _, tail = os.path.split(x)
    new_location = os.path.join(TARGET_DIR, tail)
    print(f"copy {x} to {new_location}")
    shutil.move(x, new_location)
