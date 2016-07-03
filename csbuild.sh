#build project with cscope
#add by zj, 20160703

#!/bin/bash



find . -name "*.h" -o -name "*.c" -o -name "*.cpp" > cscope.files

cscope -Rbkq -i cscope.files

ctags -R *








