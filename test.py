import os
import sys
from git.repo import Repo


class GitRepHolder:
    def __init__(self, url, dir, branch,sdkurl,sdkPath):
        self.url = url
        self.dir = dir
        self.branch = branch
        self.repo = None
        self.sdkurl=sdkurl
        self.sdkPath=sdkPath
        if not os.path.exists(dir):
            os.makedirs(dir)
        print("Checkout Git")

        git_local_path = os.path.join(dir, '.git')
        if not os.path.exists(git_local_path):
            self.repo = Repo.clone_from(url, to_path=dir, branch=branch)
        else:
            self.repo = Repo(dir)
        
    def checkout(self):
        os.chdir(self.dir)
        cmd="svn checkout "+"svn://219.142.251.142/Client/branches/develop/ . "
        print(cmd)
        os.system(cmd)
        os.system("pause")
    def checkoutSDkPro():
        if not os.path.exists(self.sdkPath):
           os.makedirs(self.sdkPath)
        gitsdk=os.path.join(self.sdkurl, '.git')
        if not os.path.exists(gitsdk):
             Repo.clone_from(self.sdkurl, to_path=self.sdkPath)
if __name__ == "__main__":
    b = "develop"    
    action = GitRepHolder("git@git.acegames.cn:lizhixiong/mosaic.git", "E://testPython/three", b,"","")
    action.checkout()
    #action.checkoutSDkPro()