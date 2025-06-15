#!/bin/bash
# 临时脚本：测试 vim 配置是否正常工作

echo "测试 Vim 配置..."

# 启动 vim 并立即退出，检查是否有错误
vim -c ':qa!' 2>&1 | grep -i error

if [ $? -eq 0 ]; then
    echo "发现错误！"
else  
    echo "配置加载正常！"
fi
