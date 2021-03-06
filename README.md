# GIT cheat sheet
**Clones revision X of gtkwave**
>`git svn clone -rX:HEAD svn://svn.code.sf.net/p/gtkwave/code/ gtkwave-code`

**Rebase svn to latest server commit**
>`git svn rebase`

**For what?**
>`git update-index --assume-unchanged [file]`

**dodaje do komita rowniez usuniete pliki**
>`git add -u .`

**Don't add untracked content**
>`git add -u`

**ile lini kodu w repo?**
>`git ls-files | xargs |wc -l`

**drukuje 10 k=komitow jednoliniowych**
>`git log --oneline -n 10`

**wraca do najnowszego kommita**
>`git checkout -`

**lista 10 komitow w skroconej formie**
>`git log -n 10 --pretty=oneline --abbrev-commit`

**powyzsze sha moze byc uzyte do porownania aktualneog komita z historycznym dla pliku**
>`git diff 8338758 connectors/dword_filler.vhd`

**For a specific file use:**
>`git checkout path/to/file/to/revert`

**For all unstaged files use:**
>`git checkout -- .`


Detached head means you are no longer on a branch, you have checked out a single commit in the history (in this case the commit previous to HEAD, i.e. HEAD^).
You only need to checkout the branch you were on, e.g.
git checkout master

**Next time you have changed a file and want to restore it to the state it is in the index, don't delete the file first, just do**
`git checkout -- path/to/foo`

**Solutions for merge conflicts**
 When local file version is proper one
`git checkout HEAD -- path/to/myfile.txt`
 When remote branch file version is desired
`git checkout remote/branch_to_merge -- path/to/myfile.txt`

**Pokazuje roznie miedzy tagami z uzglednienime zmian nazw/katalogow**
>`git diff 0.6.7 0.6.8 --stat -C HEAD HEAD^^`

**Pokjauzje orznice miedzy tagami pliku o zmienionej nazwie/latloagu**
>`git diff 0.6.7:./top/euclid_spw_top.ucf 0.6.8:./ucf/euclid_spw_top.uc`

**Show list of files differenced between branches**
```
git diff --name-status branch1 branch2`
>M file1
>M file2
>D file3
```

**A simple command already solved the problem for me if I assume that all changes are committed in both branches A and B:**
>`git checkout A`
>`git checkout --patch B f`

**Simple Way to remove untracked files**
To remove all untracked files, The simple way is to add all of them first and reset the repo as below
`git add --all`

**Remove from git, but not from filesystem**  
For single file:  
>`git rm --cached mylogfile.log`  

For single directory:
>`git rm --cached -r mydirectory`

**list files in dir/ directory containing phrases foo and bar**
>`git grep -l --all-match -e 'foo' -e 'bar' -- dir/`

