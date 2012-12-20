require 'action_view'
module Aloha
  module Rails

    module Helpers
      def aloha_script_tag(options={})
        options = {
          :type => 'text/javascript',
          :src => '/assets/aloha/lib/aloha.js',
          :plugins => Aloha::Rails.default_plugins,
          :extra_plugins => []
        }.update(options)

        plugins = options.delete(:plugins) || []
        plugins += options.delete(:extra_plugins)

        if plugins.any?
          options[:data] = {
            'aloha-plugins' => plugins.join(',') 
          }
        end

        content_tag :script, nil, options
      end

      def aloha_stylesheet_tag(options={})
        options = {
          :rel => 'stylesheet',
          :type => 'text/css',
          :href => '/assets/aloha/css/aloha.css'
        }.update(options)
        content_tag :link, nil, options
      end

      def aloha_setup(options={})
        js = <<-JS
        Aloha.ready(function() { 
          Aloha.require(Aloha.settings.modules, function(Aloha, $) {
            Aloha.onReady();
            $(Aloha.settings.editables).aloha();
          });
        });
        JS
        javascript_tag js
      end

      def aloha!(options={})
        aloha_script_tag(options[:script]) + aloha_stylesheet_tag(options[:stylesheet]) + aloha_setup(options[:setup])
      end
    end

  end
end
