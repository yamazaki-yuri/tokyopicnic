module ApplicationHelper
  def page_title(page_title = '', admin: false)
    base_title = '東京Picnic'

    page_title.empty? ? base_title : "#{page_title} - #{base_title}"
  end

  def default_meta_tags
    {
      site: '東京Picnic',
      title: '東京23区内のピクニックができる公園投稿・検索サービス',
      reverse: true,
      charset: 'utf-8',
      description: '公園をきっかけに、東京23区の行ったことがない土地に行ってみよう！ピクニックに最適な公園を目的別で探せます。公園情報を投稿して共有しよう。',
      keywords: 'ピクニック,公園,東京,東京23区',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.jpg'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@',
        image: image_url('ogp.jpg')
      }
    }
  end
end
