# Vim-korDic
This package include a vim plugin to translate Korean and English.

After the installation can be used without any setup.

# Note
It can not be compatible with both the python2(2.7) and python3(3.x) versions at the same time.

So, I split the file korDic_py.vim to korDic_py2.vim and korDic_py3.vim.

I'll be fix the version issue and add a setup.py soon.


# Install
First install the following packages.

1. vim-nox
1. python
1. python-pip

And then install the beautifulsoup4 to use a pip.

* pip install BeautifulSoup4

Finally, transfer korDic.vim file to the vim plugin directory.


# Usage
Place the cursor on the word you want to convert.

The next time you enter the command ":TS", the translated text is displayed in a new window.
