require "mongoid_ar_association/version"

module MongoidArAssociation
  def self.included(base)
    base.class_eval do
      extend  ClassMethods
    end
  end

  module ClassMethods
    # Connection methods from mongoid to mysql
    def belongs_to_record(name, options = {})
      field "#{name}_id", type: Integer
      object_class = options[:class_name].constantize || name.to_s.titleize.delete(' ').constantize
      primary_key = options[:primary_key] || object_class.primary_key
      foreign_key = options[:foreign_key] || "#{name}_id"
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank?
            self.instance_variable_set("@#{name}", object_class.where(primary_key => self.send(foreign_key)).first)
          end

          self.instance_variable_get("@#{name}")
        end

        define_method("#{name}=(new_instance)") do
          self.send("#{name}_id=", new_instance.id)
          self.instance_variable_set("@#{name}", nil)
        end
      end
    end

    def has_many_records(name, options = {})
      plural_name = name.to_s.pluralize
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class_name].constantize || name.to_s.singularize.titleize.delete(' ').constantize
      primary_key = options[:primary_key] || 'id'
      self.instance_eval do
        define_method(plural_name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank?
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.send(primary_key).to_s))
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end

    def has_one_record(name, options = {})
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class_name].constantize || name.to_s.titleize.delete(' ').constantize
      primary_key = options[:primary_key] || 'id'
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank?
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.send(primary_key).to_s).first)
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end

    # Connection methods from mysql to mongoid
    def belongs_to_document(name, options = {})
      object_class = options[:class_name].constantize || name.to_s.titleize.delete(' ').constantize
      primary_key = options[:primary_key] || self.class.primary_key
      foreign_key = options[:foreign_key] || "#{name}_id"
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank?
            self.instance_variable_set("@#{name}", object_class.where(primary_key => self.send(foreign_key)).first)
          end

          self.instance_variable_get("@#{name}")
        end

        define_method("#{name}=(new_instance)") do
          self.send("#{name}_id=", new_instance.id)
          self.instance_variable_set("@#{name}", nil)
        end
      end
    end

    def has_many_documents(name, options = {})
      plural_name = name.to_s.pluralize
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class_name].constantize || name.to_s.singularize.titleize.delete(' ').constantize
      primary_key = options[:primary_key] || self.class.primary_key
      self.instance_eval do
        define_method(plural_name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank?
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.send(primary_key)))
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end

    def has_one_document(name, options = {})
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class_name].constantize || name.to_s.titleize.delete(' ').constantize
      primary_key = options[:primary_key] || self.class.primary_key
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank?
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.send(primary_key)).first)
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end
  end
end
