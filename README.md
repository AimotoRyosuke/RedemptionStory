# Database

## users table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|image|string|null: false|
|sex|string|null: false|
|birth|stirng|null: false|

#### assosiation
---
## sns_auths table
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|
|uid|string|null: false|
|user_id|references|null: false, foreign_key: true|

#### assosiation
---
## posts table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|text|text|null: false|
|date|date|null: false|

#### assosiation
---
## images table
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|post_id|references|null: false, foreign_key: true|

#### assosiation
---
## comments table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

#### assosiation
---
## likes table
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

#### assosiation
---
## follows table
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|follow_id|references|null: false, foreign_key: true|

#### assosiation
---
## tags table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

#### assosiation
---
## post-tags table
|Column|Type|Options|
|------|----|-------|
|tag_id|references|null: false, foreign_key: true|
|post_id|references|null: false, foreign_key: true|

#### assosiation
---