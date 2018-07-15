require 'spec_helper'

module Commercelayer
  RSpec.describe Resource do

    include_context "shared context"

    it "works" do
      Commercelayer::Sku.order(code: :desc).includes(:prices, :stock_items).each_total do |sku|
        puts sku.code
        puts sku.prices.inspect
        puts sku.stock_items.inspect
      end
    end

  end
end
