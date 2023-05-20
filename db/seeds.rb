# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: "admin@admin", password: "111111")
Genre.create([
    { name: '動物', is_active: true },
    { name: '漫画', is_active: true  },
    { name: 'かわいい', is_active: true },
    { name: 'キャラ', is_active: true },
    { name: 'ひよこ', is_active: true },
    ])