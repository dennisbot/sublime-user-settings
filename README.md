# sublime-user-settings
This repository holds my personal/favorite configuration files within my User folder along with a custom Git plugin (tweaked version from https://github.com/kemayo/sublime-text-git)

User folder location: (Preferences -> Browse Packages ...) then go inside `User` folder in order to see the content.

Thanks to this repository I'll be able to share my preferences among any other instance of sublime I might be running over
different OSs.

run `setup-symlinks.ps1` in powershell with admin rights:

```powershell
PS C:\gh.com\dennisbot\sublime-user-settings> .\setup-symlinks.ps1
```

It's likely that you get some displaying error due to missing Theme Packages, please, install Package Manager first, then invoke the install package "theme bamboo", it'll fix the displaying issue (using the mouse pointer, the displaying issue might be annoying at this point).

Please, be aware that the name of `Default (Windows).sublime-keymap`
file [will be different across different OS](http://sublimetext.info/docs/en/reference/key_bindings.html)
(in case the target OS is MacOS or Linux), so better to have
three different files with the same content among them, just duplicate the file and rename it according to your
target OS.
