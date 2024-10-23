# TinyHTTP

简单的HTTP请求库。使用的是URLSession，支持Codable。

## 使用方式

1. 引入submodule
```ruby
super $ git submodule add https://git.hiscene.net/hileia/hileiaservice/TinyHTTP.git
```

2. 检出子仓库
```ruby
super $ git submodule update --init
```

3. 创建本地分支跟踪远程仓库的代码
```ruby
super $ cd TinyHTTP
sub $ git checkout -b master
```

4. 更新子仓库引用位置
```ruby
sub $ cd ..
super $ git add TinyHTTP
super $ git commit -m 'up TinyHTTP to date'
super $ git push
```

以子仓库的方式加入到你的仓库中，将代码作为你的项目源码使用。
[git submodule使用指南](https://git.hiscene.net/fei.xie/tutorials/-/blob/master/git_related/git_submodules.md)
