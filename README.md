# MongoidArAssociation

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mongoid_ar_association'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid_ar_association

## Usage

Include the module

```ruby
include MongoidArAssociation
```

Create association like:
* Connection methods from mongoid to mysql:
    belongs_to_record
    has_one_record
    has_many_records

* Connection methods from mysql to mongoid:
    belongs_to_document
    has_one_document
    has_many_documents

examples
```
has_many_records :addresses, class_name: "User", primary_key: :id, foreign_key: :user_id
```

```
has_many_documents :addresses, class_name: "User", primary_key: :id, foreign_key: :user_id
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mongoid_ar_association/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
