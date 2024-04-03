# tokyopicnic
## サービス概要

東京23区にある、ピクニック可能な公園を提案する

## このサービスへの思い・作りたい理由

ヒトとモノに溢れる東京で、忙しく暮らしている人が多いと思います。
私もその一人です。
休日はゆっくりと過ごしたい、できれば自然の中で非日常を感じたいと思いつつ、キャンプなどのアウトドアは準備も移動も大変。
そんな時、都内でピクニックなら手軽に自然も非日常も手に入れられると思い、友人と都内の公園を巡り始めました。
ピクニックができる公園を探すとき、アクセスの良さ・周辺で飲食の調達ができるか・有料か・飲酒はできるか・シートは広げられるかなどを考慮して公園を決定するのが大変で、目的別で検索できるアプリがあればいいと思ったことがアプリ作成のきっかけです。
また、私は東京に生まれ育ち、東京という街が好きなのですが、行ったことがない場所はたくさんあります。
行ったことがないだけで、魅力のある場所というのはたくさんあるはずという思いと、ずっと暮らしている割に土地勘がないという悔しさがあり、東京23区を制覇するという目的を持たせたアプリにしたいと思いました。
アクセスの良さを考慮すると、普段は行こうとはならない未知な場所にも、公園を通して訪れるきっかけ作りになったら良いと思っています。

## ユーザー層について

東京に暮らす人
休日はゆっくりと過ごしたいと思っている人

## サービスの利用イメージ

### ユーザー登録せずに以下のことができる

1. 公園の検索。検索条件は飲酒可能かなどの利用目的のタグごとに検索ができる。
2. top画面から、"**公園を見つける**"といったボタンを押すと、ランダムに公園を選定されて新たな公園を提案する。
3. 公園の詳細に飛べる。その他の公園も検索できる。
4. 公園の詳細ページには、公園の設備案内のほかにGooglemap上にその公園にピンが刺さっている状態で表示される。

利用価値 : この公園に行ってみようというきっかけになる

### ユーザー登録するとできること

1. ランダム選定された公園に行ってみたいという登録ができる。マイページに行くと一覧が見られるので、次に行きたい公園をわざわざ検索しなくて良い。
2. 23区のどこに行ったかを可視化する(23区の一覧が灰色のボックスで表示される。自分の公園の記録を投稿すると、該当の区に写真が増える想定)
3. 自分のピクニックした時の記録などを残せる。(公園の区を指定・公園名入力・日付・写真・食料調達場所・過ごし方・一言を登録できる)

利用価値 : 休日の過ごし方として、23区を制覇しようという目的を得られる

### 管理者画面
公園の設備情報の登録・編集は管理者画面で行う。ユーザーのピクニックの記録投稿時に、データベースにない公園を投稿しようとした際は、公園の情報はデフォルトで未入力の状態で、区と公園名だけ新たにデータベースに登録されるようにする。
公園の情報は施設の公式サイトを参照して、登録していく想定です。
MVPリリース時には、23区全ての区に、一つ以上の公園の情報が存在するようにする予定です。

## サービスの差別化ポイント・推しポイント

picnicに特化したサービスである。
googlemapでは、ある程度範囲を決めた中での公園検索しかできない。
公園の検索の仕方として、飲酒可・シート可・区の選択などのあらかじめ用意したタグでの検索を想定しており、ピクニックをする上で、ユーザーの目的に合う情報を絞った検索ができる。

## 機能候補

### MVP

- トップページ
- ユーザー登録
- ログイン機能
- 公園検索機能
- 公園ランダム選定機能
- 行ってみたいに登録機能
- 管理者画面の登録(公園情報登録機能)

### その後の機能

- 23区スタンプ機能
- 公園情報投稿機能
- googleログイン機能

## 機能の実装方針予定

- ログイン機能にdeviseの使用
- googleログインにgoogleAPIの使用
- rails(7系使用)
- ruby(3.2.2)
- tailwindcssとdaisyuiの使用

###  画面遷移図
https://www.figma.com/file/jT1IMXubZj3C5haz9rBoeb/%E6%9D%B1%E4%BA%ACpicnic?type=design&node-id=0%3A1&mode=design&t=K2ya1b8wpj57kgBq-1