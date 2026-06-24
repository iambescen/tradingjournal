#!/bin/bash
# Проставляет дату/время сборки в BUILD_VERSION/BUILD_DATE.
# Запускать ПЕРЕД коммитом: ./stamp_version.sh && git add -A && git commit ...
python3 - << 'PY'
import re
from datetime import datetime, timezone, timedelta
msk = timezone(timedelta(hours=3))
now = datetime.now(msk)
ver  = now.strftime('%d.%m %H:%M')
date = now.strftime('%d.%m.%Y %H:%M МСК')
s = open('index.html').read()
s = re.sub(r"const BUILD_VERSION = '[^']*';", "const BUILD_VERSION = '"+ver+"';", s)
s = re.sub(r"const BUILD_DATE    = '[^']*';", "const BUILD_DATE    = '"+date+"';", s)
open('index.html','w').write(s)
print('Версия:', ver)
PY
