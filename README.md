
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dalopop

<!-- badges: start -->
<!-- badges: end -->

dalopopは、大阪府の人口データを集めて活用するためのツールです。
大阪府のホームページで公表されている月次の人口データをダウンロードして、
SQLiteのデータベースファイルにするための関数を用意しています。

このツールで利用するデータは、 大阪府が公表している
「[大阪府の毎月推計人口](https://www.pref.osaka.lg.jp/fuseiunei/toukeijouhou/toukeikajisshinochousa/maitsukisuikeijinkou/index.html)」に基づくものです。

URL:<https://www.pref.osaka.lg.jp/fuseiunei/toukeijouhou/toukeikajisshinochousa/maitsukisuikeijinkou/index.html>

当該データ自体のライセンスに関する明記はありませんが、
「[利用上の注意](https://www.pref.osaka.lg.jp/o040090/toukei/jinkou/jinkou-chuui.html)」のページがあるので目を通してください。

## インストール

dalopopは、githubからインストールできます。
また、dalopopは、特に、`rabbit`パッケージと
`dalo`パッケージに依存しているので、以下のようにインストールします。
その他で必要になるパッケージは自動的にインストールされるはずです。

``` r
# install.packages("devtools")
devtools::install_github("syunsuke/rabbit")
devtools::install_github("syunsuke/dalo")
devtools::install_github("syunsuke/dalopop")
```

また、リレイショナルデータベース SQLiteが必要です。

[https://www.sqlite.org/](https://www.sqlite.org/)


## 基本的な使い方

### Rプロジェクト作成

人口データベースを管理するRプロジェクトを作ります。

### キャッシュディレクトリを準備

大阪府の配布するエクセルファイルをキャッシュするディレクトリを作ります。

### 初期化

`dalopop_init_sqlite`コマンドで、データベースを作成して初期化。


```
dbname <- "osaka_population.sqlite"
dalopop_init_sqlite(dbname)
```

### 管理

`dalopop_update_sqlite`コマンドで、データベースを最新状態にアップデート


```
d <- "data"
dalopop_update_sqlite(d, dbname)
```

キャッシュ用のディレクトリと、
sqliteデータベースファイル名を引数に与えるだけです。
自動的に大阪府のページからエクセルファイルをダウンロードし、
そのエクセルファイルをSQLiteのデータベースに書き込んでくれます。

重複しているファイルは、ダウンロードされません。
また、既に書き込んだデータは、SQLiteに上書きされません。

気軽にアップデートしましょう。


### エクスポート

`dalopop_export_excel`コマンドで、
比較的扱いやすいデータの形にして、
エクセルファイルとして出力できます。

```
dalopop_export_excel(dbname)
```

デフォルトでは大阪府下全てのデータをエクスポートします。

しかし、地域を選択することも出来ます。


```
myarea <- c("枚方市","寝屋川市","交野市","四條畷市","大東市")
dalopop_export_excel(dbname, areas = myarea)
```

5歳区分別人口の区分をデフォルトの85歳から、95歳に変更できます。
（但し、比較的新しい時点のもののみ）

```
dalopop_export_excel(dbname, age85 = FALSE, areas = myarea)
```

エクスポートするファイル名は、`output`オプションで指定できます。

```
dalopop_export_excel(dbname, 
                     age85 = FALSE, 
                     areas = myarea,
                     output = "No9Bunkakai.xlsx"
                     )
```


