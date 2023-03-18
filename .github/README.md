# Date Time
[heading__top]:
  #date-time
  "&#x2B06; Commands for injecting date and/or time into current buffer"


Commands for injecting date and/or time into current buffer

## [![Byte size of Date Time][badge__main__date_time__source_code]][date_time__main__source_code] [![Open Issues][badge__issues__date_time]][issues__date_time] [![Open Pull Requests][badge__pull_requests__date_time]][pull_requests__date_time] [![Latest commits][badge__commits__date_time__main]][commits__date_time__main] [![License][badge__license]][branch__current__license]


---


- [:arrow_up: Top of Document][heading__top]

- [:building_construction: Requirements][heading__requirements]

- [:zap: Quick Start][heading__quick_start]

- [&#x1F9F0; Usage][heading__usage]

  - [Replace selection example][heading__replace_selection_example]
  - [Insert and append examples][heading__insert_and_append_examples]

- [&#x1F5D2; Notes][heading__notes]

- [:chart_with_upwards_trend: Contributing][heading__contributing]

  - [:trident: Forking][heading__forking]
  - [:currency_exchange: Sponsor][heading__sponsor]

- [:card_index: Attribution][heading__attribution]

- [:balance_scale: Licensing][heading__license]


---



## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; Prerequisites and/or dependencies that this project needs to function properly"


This repository requires the [Vim][vim_home] text editor to be installed the source code is available on [GitHub -- `vim/vim`][vim__github], and most GNU Linux package managers are able to install Vim directly, eg...


- Arch based Operating Systems


```Bash
sudo packman -Syy

sudo packman -S vim
```


- Debian derived Distributions


```Bash
sudo apt-get update

sudo apt-get install vim
```


______


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; Perhaps as easy as one, 2.0,..."


This repository is a Vim plugin and can be installed via a number of methods.


0. [Source][date_time__main__source_code]

   ```Bash
   mkdir -p ~/git/hub/vim-utilities

   cd ~/git/hub/vim-utilities/date-time

   git clone git@github.com:vim-utilities/date-time.git

   make install
   ```


1. [Plug](https://github.com/junegunn/vim-plug)

   **`~/.vimrc` (snip)**

   ```vim
   call plug#begin('~/.vim/plugged')
     " ...
     Plug 'vim-utilities/date-time'
     " ...
   call plug#end()
   ```

   After adding above `Plug` line to your Vim configuration file, run the following `PlugInstall` Ex mode command within a Vim session

   ```vim
   :PlugInstall date-time
   ```


2. [Vundle](https://github.com/VundleVim/Vundle.vim)

   **`~/.vimrc` (snip)**

   ```vim
   call vundle#begin('~/.vim/plugged')
     " ...
     Plugin 'vim-utilities/date-time'
     " ...
   call vundle#end()
   ```

   After adding above `Plugin` line to your Vim configuration file, run the following `PluginInstall` Ex mode command within a Vim session

   ```vim
   :PluginInstall
   ```


______


## Usage
[heading__usage]:
  #usage
  "&#x1F9F0; How to utilize this repository"


After installation use `help` to review configuration, and usage, details, eg.


```vim
:help date-time.txt

" Jump to specific sections
:help date-time-ex-commands
:help date-time-normal-map
:help date-time-visual-map
:help date-time-configuration
:help date-time-notes
```


Alternatively plugin documentation maybe reviewed within
[`doc/date-time.txt`][branch__current__doc__date_time] file.


---


### Replace selection example
[heading__replace_selection_example]: #replace-selection-example


By default the `<Leader>R` sequence in Visual select mode will _`R`eplace_ any
date/time format strings.


Consider the following template time-sheet CSV;

```csv
date,start,stop,description

%F,%R,%R,DESCRIPTION
```

... which can be quickly modified via the following sequence of steps;


- **Normal mode**
  - `G` normal mode we can jump to the end of the buffer
  - `yy` to yank the whole line
  - `gg` to jump to the top of the buffer
  - `P` to put/past before cursor position
  - `v` to enter Visual select mode


- **Visual mode**
  - `t,;` select _`t`ill_ comma (`,`) and `;` to repeat once
  - `<Leader>R`
  - selected `%F,%R` text will be replaced via `strftime` built-in function

> Note; mode will automatically switch to Normal


**Example result**

```csv
date,start,stop,description
2023-03-18,14:04,%R,DESCRIPTION

%F,%R,%R,DESCRIPTION
```


---


### Insert and append examples
[heading__insert_and_append_examples]: #insert-and-append-examples


By default Normal mode `<Leader>t` (or `T`), and `<Leader>d` (or `D`), motions
will append or insert the current time or date respectively.

> Tip; this can be useful in combination with <kbd>Ctrl</kbd>^<kbd>o</kbd> from
> Insert mode to avoid breaking one's flow of thought.


Consider the following text;

```text
I will see you later today (
```

... which may have current date appended via the following sequence of steps;


- **Insert mode**
  - <kbd>Ctrl</kbd>^<kbd>o</kbd>

- **(insert)/Normal mode**
  - `<Leader>d`

- **Insert mode**
  - `) to discuss something`


**Example result**

```text
I will see you later today (2023-03-18) to discuss something
```


______


## Notes
[heading__notes]:
  #notes
  "&#x1F5D2; Additional things to keep in mind when developing"


This repository may not be feature complete and/or fully functional, Pull
Requests that add features or fix bugs are certainly welcomed.



______


## Contributing
[heading__contributing]:
  #contributing
  "&#x1F4C8; Options for contributing to date-time and vim-utilities"


Options for contributing to date-time and vim-utilities


---


### Forking
[heading__forking]:
  #forking
  "&#x1F531; Tips for forking date-time"


Start making a [Fork][date_time__fork_it] of this repository to an account that you have write permissions for.


- Add remote for fork URL. The URL syntax is _`git@github.com:<NAME>/<REPO>.git`_...


```Bash
cd ~/git/hub/vim-utilities/date-time

git remote add fork git@github.com:<NAME>/date-time.git
```


- Commit your changes and push to your fork, eg. to fix an issue...


```Bash
cd ~/git/hub/vim-utilities/date-time


git commit -F- <<'EOF'
:bug: Fixes #42 Issue


**Edits**


- `<SCRIPT-NAME>` script, fixes some bug reported in issue
EOF


git push fork main
```


> Note, the `-u` option may be used to set `fork` as the default remote, eg. _`git push -u fork main`_ however, this will also default the `fork` remote for pulling from too! Meaning that pulling updates from `origin` must be done explicitly, eg. _`git pull origin main`_


- Then on GitHub submit a Pull Request through the Web-UI, the URL syntax is _`https://github.com/<NAME>/<REPO>/pull/new/<BRANCH>`_


> Note; to decrease the chances of your Pull Request needing modifications before being accepted, please check the [dot-github](https://github.com/vim-utilities/.github) repository for detailed contributing guidelines.


---


### Sponsor
  [heading__sponsor]:
  #sponsor
  "&#x1F4B1; Methods for financially supporting vim-utilities that maintains date-time"


Thanks for even considering it!


Via Liberapay you may <sub>[![sponsor__shields_io__liberapay]][sponsor__link__liberapay]</sub> on a repeating basis.


Regardless of if you're able to financially support projects such as date-time that vim-utilities maintains, please consider sharing projects that are useful with others, because one of the goals of maintaining Open Source repositories is to provide value to the community.


______


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [GitHub -- `github-utilities/make-readme`](https://github.com/github-utilities/make-readme)


______


## License
[heading__license]:
  #license
  "&#x2696; Legal side of Open Source"


```
Commands for injecting date and/or time into current buffer
Copyright (C) 2023 S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

```


For further details review full length version of [AGPL-3.0][branch__current__license] License.



[branch__current__license]:
  /LICENSE
  "&#x2696; Full length version of AGPL-3.0 License"

[branch__current__doc__date_time]:
  /doc/date-time.txt
  "`:help date-time.txt` plugin documentation"

[badge__license]:
  https://img.shields.io/github/license/vim-utilities/date-time

[badge__commits__date_time__main]:
  https://img.shields.io/github/last-commit/vim-utilities/date-time/main.svg

[commits__date_time__main]:
  https://github.com/vim-utilities/date-time/commits/main
  "&#x1F4DD; History of changes on this branch"


[date_time__community]:
  https://github.com/vim-utilities/date-time/community
  "&#x1F331; Dedicated to functioning code"


[issues__date_time]:
  https://github.com/vim-utilities/date-time/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."

[date_time__fork_it]:
  https://github.com/vim-utilities/date-time/fork
  "&#x1F531; Fork it!"

[pull_requests__date_time]:
  https://github.com/vim-utilities/date-time/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"

[date_time__main__source_code]:
  https://github.com/vim-utilities/date-time/
  "&#x2328; Project source!"

[badge__issues__date_time]:
  https://img.shields.io/github/issues/vim-utilities/date-time.svg

[badge__pull_requests__date_time]:
  https://img.shields.io/github/issues-pr/vim-utilities/date-time.svg

[badge__main__date_time__source_code]:
  https://img.shields.io/github/repo-size/vim-utilities/date-time


[vim__home]:
  https://www.vim.org
  "Home page for the Vim text editor"

[vim__github]:
  https://github.com/vim/vim
  "Source code for Vim on GitHub"

