# Aloha::Rails

Power your Rails 3 app with the Aloha Editor.

## Installation

Add this line to your application's Gemfile:

    gem 'aloha-rails'

Run the generator to install the Aloha config files and integrate Aloha to the assets pipeline:

    rails generate aloha:install [--js]

Pass `--js` if you want the javascript version.

## Usage

Edit these files to configure Aloha (there are explanations inside them):

    * app/assets/javascripts/aloha-config.(coffee|js)
    * config/initializers/aloha.rb


To setup aloha, add this in the &lt;head&gt; section of your template:

    <%= javascript_include_tag 'application' %>
    <%= aloha! %>

Finally, to make things editable, add a `.editable-(long|short)-text` to the HTML element:

    <%= content_tag :div, :class => 'editable-long-text' do %>
      <p>Lorem Ipsum...</p>
    <% end %>

