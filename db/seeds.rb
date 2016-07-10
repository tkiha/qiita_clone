users = User.create([
                        { name: 'テスター1', email: 'test@test.com', password: 'test' },
                        { name: 'テスター2', email: 'test2@test.com', password: 'test' },
                        { name: 'テスター3', email: 'test3@test.com', password: 'test' },
                        { name: 'テスター4', email: 'test4@test.com', password: 'test' },
                    ])

tags = Tag.create([
                      { name: 'タグ1' },
                      { name: 'タグ2' },
                      { name: 'タグ3' },
                      { name: 'タグ4' },
                  ])

items = Item.create([
                        { aasm_state: 'published', published_at: Time.now, user: users.first, title: 'タイトル1', content: "あああああああああ\r\n\r\n- a\r\n- a\r\n- a\r\n\r\n> あああああああああああ\r\n\r\n# a\r\n\r\n## aa\r\n\r\n### aaa\r\n\r\n*aaaaaaa*\r\n\r\n**aaaaaaaa**\r\n\r\n`aaaaaaaaaaaaa`\r\n\r\n```\r\naaaaaaaaaaa\r\n````\r\n" },
                        { aasm_state: 'published', published_at: Time.now, user: users.first, title: 'タイトル2', content: "# 投稿2" },
                        { aasm_state: 'published', published_at: Time.now, user: users.first, title: 'タイトル3', content: "# 投稿3" },
                        { aasm_state: 'published', published_at: Time.now, user: users.second, title: 'タイトル4', content: "# 投稿4" },
                        { aasm_state: 'published', published_at: Time.now, user: users.second, title: 'タイトル5', content: "# 投稿5" },
                        { aasm_state: 'published', published_at: Time.now, user: users.second, title: 'タイトル6', content: "# 投稿6" },
                    ])

TagItem.create([
                   { item: items.first, tag: tags.first },
                   { item: items.first, tag: tags.second },
                   { item: items.second, tag: tags.first },
                   { item: items.second, tag: tags.second },
                   { item: items.second, tag: tags.third },
                   { item: items.third, tag: tags.fourth },
               ])

