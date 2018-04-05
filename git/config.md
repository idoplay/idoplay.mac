```
git config --global branch.master.rebase true //Pull的时候自动rebase
git config --global branch.autosetuprebase always

git config --global core.autocrlf true //Windows系统上 这样当签出代码时，LF会被转换成CRLF
git config --global core.autocrlf input //Linux/Unix/Mac 在提交时把CRLF转换成LF，签出时不转换
Windows下使用Git 配置支持unicode文件名

git config --global core.quotepath off
git config --global --unset i18n.logoutputencoding
git config --global --unset i18n.commitencoding
git config --global --unset svn.pathnameencoding

设置gitconfig，比如在"C:\Users\Username\.gitconfig"下，记得也需要保存为UTF-8 without BOM
如果使用第三方编辑器修改commit comment，注意文件保存时为UTF-8 without BOM，以及LF换行符。
```
