# [odinbook](https://morning-coast-23139.herokuapp.com/home)

Social networking for the divine.

This is the first project I've completed using voice-coding.

[![screenshot](/screenshot.png)](https://morning-coast-23139.herokuapp.com/home)

## Notes

### PostgreSQL differences

Creating a self-referential association in sqlite looks something like this. 

`friend_id` will be a foreign key which actually points to another user in the `users` table.

```
create_table :friendships do |t|
  t.references :friend, foreign_key: true
```

But postgres actually checks that references are valid and will complain: `PG::UndefinedTable: ERROR:  relation "friends" does not exist`

We just need to tell it which table the foreign key is actually intended for.

```
create_table :friendships do |t|
  t.references :friend, foreign_key: { to_table: :users }
```

### Mutual/bi-directional Associations

These blog posts were helpful in figuring out a solid way to make friendships happen.
[Mutual Friendship in Rails](https://dankim.io/mutual-friendship-rails/)

[Bi-Directional and Self-Referential Associations in Rails](https://collectiveidea.com/blog/archives/2015/07/30/bi-directional-and-self-referential-associations-in-rails)
