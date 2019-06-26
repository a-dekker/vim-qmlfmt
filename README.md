# Vim plugin for qmlfmt

Based on [shfmt](https://github.com/z0mbix/vim-shfmt)

The **Vim qmlfmt** plugin runs [qmlfmt](https://github.com/jesperhh/qmlfmt) to auto format the current buffer

## Requirements

You just need the **`qmlfmt`** command

## Installation

Obtain a copy of this plugin and place `qmlfmt.vim` in your Vim plugin directory or be sensible and use something like Plug:

```
Plug 'a-dekker/vim-qmlfmt', { 'for': 'qml' }
```

or via vundle:
```
" qml formatter
Plugin 'a-dekker/vim-qmlfmt'
```

## Usage

You can use the `:Qmlfmt` command to run qmlfmt and automatically format the current buffer

You can also use the `:Qmlfmt` command together with options. For example,

```
:Qmlfmt -t 4
```

```
:Qmlfmt -i 2
```

### Configuration

**qmlfmt** uses tabs by default for auto formatting, so if you prefer to use 2 spaces, you can set the following in your `.vimrc` file:

```viml
let g:qmlfmt_extra_args = '-i 2'
```

### Auto format on save

If you would like to auto format shell scripts on save, you can add the following to your vim config:

```viml
let g:qmlfmt_fmt_on_save = 1
```

## License

The Vim qmlfmt plugin is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).
