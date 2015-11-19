require 'ruby-swagger/grape/type'

module Swagger::Grape
  class Param

    def initialize(param)
      @param = param
    end

    def to_swagger
      swagger_param = {}
      swagger_param['description'] = @param[:desc]  if @param[:desc].present?
      swagger_param['default'] = @param[:default]   if @param[:default].present?
      swagger_param['default'] = swagger_param['default'].call.to_s if swagger_param['default'].respond_to? :call

      swagger_param.merge! Swagger::Grape::Type.new(@param[:type]).to_swagger

      swagger_param
    end

    def has_type_definition?
      type.downcase == 'object'
    end

    def type_definition
      (Object.const_get(type)).to_s
    end

    def type
      @param[:type].to_s || 'string'
    end

  end
end
