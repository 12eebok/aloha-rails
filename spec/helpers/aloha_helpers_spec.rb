require 'spec_helper'

describe "Aloha::Rails::Helpers" do

  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::JavaScriptHelper
  include Aloha::Rails::Helpers

  context "aloha_script_tag" do

    it "returns a javascript tag" do
      aloha_script_tag.should match(%r{<script.+type="text/javascript"></script>})
    end

    it "script src is '/assets/aloha/lib/aloha.js'" do
      aloha_script_tag.should match(%r{src="/assets/aloha/lib/aloha.js"})
    end

    context "without options" do
      it "inserts the default set of plugins as data tags" do
        Aloha::Rails.stub(:default_plugins) { %w(common/foo common/bar) }
        aloha_script_tag.should match(%{data-aloha-plugins="common/foo,common/bar"})
      end
    end

    context "with custom src" do
      it "script src is 'https://raw.github.com/Skalar/aloha-rails/master/vendor/assets/javascripts/aloha/lib/aloha.js'" do
        aloha_script_tag(:src => "https://raw.github.com/Skalar/aloha-rails/master/vendor/assets/javascripts/aloha/lib/aloha.js").should match(%r{src="https://raw.github.com/Skalar/aloha-rails/master/vendor/assets/javascripts/aloha/lib/aloha.js"})
      end
    end

    context "plugins" do

      context "when passing :plugins" do
        it "uses the given plugins as data tags" do
          aloha_script_tag(:plugins => ['custom/foo', 'custom/bar']).should match(%r{data-aloha-plugins="custom/foo,custom/bar"})
        end

        it "uses no plugins if plugins is nil" do
          aloha_script_tag(:plugins => nil).should_not match(/data-aloha-plugins/)
        end
      end

    end

    context "extra_plugins" do
      it "appends the plugins to the default plugin list" do
        Aloha::Rails.stub(:default_plugins) { %w(foo/bar) }
        aloha_script_tag(:extra_plugins => [ 'custom/foo' ]).should match(%{data-aloha-plugins="foo/bar,custom/foo"})
      end

      it "removes default plugins if :plugins is set to nil" do
        aloha_script_tag(:plugins => nil, :extra_plugins => [ 'foobar' ]).should match('data-aloha-plugins="foobar"')
      end

    end

    context "with other custom option" do
      it "script other-option is 'other-option-value'" do
        aloha_script_tag('other-option' => "other-option-value").should match(%r{other-option="other-option-value"})
      end
    end

  end

  context "aloha_stylesheet_tag" do

    it "returns a stylesheet tag" do
      aloha_stylesheet_tag.should match(%r{<link.+rel="stylesheet" type="text/css">})
    end

    context "without options" do
      it "stylesheet href is '/assets/aloha/css/aloha.css'" do
        aloha_stylesheet_tag.should match(%r{href="/assets/aloha/css/aloha.css"})
      end
    end

    context "with custom href" do
      it "stylesheet href is 'https://raw.github.com/Skalar/aloha-rails/master/vendor/assets/javascripts/aloha/css/aloha.css'" do
        aloha_stylesheet_tag(:href => "https://raw.github.com/Skalar/aloha-rails/master/vendor/assets/javascripts/aloha/css/aloha.css").should match(%r{href="https://raw.github.com/Skalar/aloha-rails/master/vendor/assets/javascripts/aloha/css/aloha.css"})
      end
    end

    context "with other custom option" do
      it "stylesheet other-option is 'other-option-value'" do
        aloha_stylesheet_tag('other-option' => "other-option-value").should match(%r{other-option="other-option-value"})
      end
    end

  end

  context "aloha_setup" do

    it "returns a javascript tag" do
      aloha_setup.should match(%r{<script type="text/javascript">})
    end

  end

  context "aloha!" do

    context "without options" do
      it "returns aloha_script_tag, aloha_stylesheet_tag and aloha_setup" do
        self.should_receive(:aloha_script_tag) { "<script>" } 
        self.should_receive(:aloha_stylesheet_tag) { "<stylesheet>" } 
        self.should_receive(:aloha_setup) { "<setup>" }
        aloha!.should eq("<script><stylesheet><setup>")
      end
    end

    context "with some options" do
      it "returns aloha_script_tag, aloha_stylesheet_tag and aloha_setup" do
        self.should_receive(:aloha_script_tag).with( 'some-script-option' => "some-script-option-value" ) { "<script>" } 
        self.should_receive(:aloha_stylesheet_tag).with( 'some-stylesheet-option' => "some-stylesheet-option-value" ) { "<stylesheet>" } 
        self.should_receive(:aloha_setup).with( 'some-setup-option' => "some-setup-option-value" ) { "<setup>" }
        aloha!(
          :script => { 'some-script-option' => "some-script-option-value" },
          :stylesheet => { 'some-stylesheet-option' => "some-stylesheet-option-value" },
          :setup => { 'some-setup-option' => "some-setup-option-value" }
        ).should eq("<script><stylesheet><setup>")
      end
    end

  end

end
