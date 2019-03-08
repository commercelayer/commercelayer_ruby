require 'spec_helper'

module Commercelayer
  RSpec.describe Resource do

    include_context "shared context"

    it "works with SKUs" do
      Commercelayer::Sku.order(code: :desc).includes(:prices, :stock_items).each do |sku|
        puts sku.code
        puts sku.prices.inspect
        puts sku.stock_items.inspect
      end
    end

    it "works with Shipments" do
      Commercelayer::Shipment.includes("shipment_line_items.line_item.item").each do |shipment|
        puts shipment.id
        shipment.shipment_line_items.each do |shipment_line_item|
          puts shipment_line_item.line_item.first.item.inspect
        end
      end
    end

  end
end
