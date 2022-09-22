import glob
import os
import shutil
from tqdm import tqdm

TARGET_DIR = './data/editions'

os.makedirs('./data/editions', exist_ok=True)

files = sorted(glob.glob('./pez-editions-legacy-master/102_derived_tei/102_07_bequest/msDesc/*/*.xml'))
print(len(files))


for x in tqdm(files, total=len(files)):
    _, tail = os.path.split(x)
    new_location = os.path.join(TARGET_DIR, tail)
    shutil.move(x, new_location)
