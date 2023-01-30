import glob
import os
import shutil
from tqdm import tqdm
from acdh_tei_pyutils.tei import TeiReader

TARGET_DIR = './data/editions'

os.makedirs('./data/editions', exist_ok=True)

files = sorted(glob.glob('./pez-editions-legacy-master/102_derived_tei/102_07_bequest/msDesc/*/*.xml'))
print(len(files))


for x in files:
    if os.environ.get('TESTRUN'):
        if 'msDesc_411087.xml' in x or 'msDesc_407573.xml' in x:
            _, tail = os.path.split(x)
            new_location = os.path.join(TARGET_DIR, tail)
            print(f"copy {x} to {new_location}")
            shutil.move(x, new_location)
    else:
        _, tail = os.path.split(x)
        new_location = os.path.join(TARGET_DIR, tail)
        print(f"copy {x} to {new_location}")
        shutil.move(x, new_location)

files = sorted(glob.glob('./data/editions/*.xml'))
for x in tqdm(files):
    doc = TeiReader(x)
    for y in doc.any_xpath('//tei:graphic'):
        old = y.attrib["url"].split('/')[-1]
        new = y.attrib["url"] = f"https://id.acdh.oeaw.ac.at/pez-nachlass/{old}.tif"
    doc.tree_to_file(x)