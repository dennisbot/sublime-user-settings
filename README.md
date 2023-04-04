# sublime-user-settings
This repository holds my personal/favorite configuration files within my User folder (Preferences -> Browse Packages ...) then go inside `User` folder
in order to see the content.

Thanks to this repository I'll be able to share my preferences among any other instance of sublime I might be running over
different OSs.

Use the following command to be able to use the files from its git source (update with your correct path):

```bash
mklink /D "C:\Users\user\AppData\Roaming\Sublime Text 3\Packages\User" "C:\github.com\dennisbot\sublime-user-settings"
```

It's likely that you get some displaying error due to missing Theme Packages, please, install Package Manager first, then invoke the install package "theme bamboo", it'll fix the displaying issue (using the mouse pointer, the displaying issue might be annoying at this point).

Please, be aware that the name of `Default (Windows).sublime-keymap`
file [will be different across different OS](http://sublimetext.info/docs/en/reference/key_bindings.html)
(in case the target OS is MacOS or Linux), so better to have
three different files with the same content among them, just duplicate the file and rename it according to your
target OS.

# setup custom sublime-text-git plugin

I'm using a tweaked version of sublime-text-git plugin, run the following command (update with your correct path):
```bash
mklink /D "C:\Users\user\AppData\Roaming\Sublime Text 3\Packages\Git" "C:\github.com\dennisbot\sublime-text-git"
```

where the first part is the link and the last one the target (the git source)