# frozen_string_literal: true

module Broker
  module Adaptee
    module ResponseNormalizers
      # Responsible for normalizing response from API
      module Bitfinex
        def order_book(response)
          json = JSON.parse(response)

          parse(json, Broker::Settings::General.ask_side) +
            parse(json, Broker::Settings::General.bid_side)
        end

        def parse(json, side = Broker::Settings::General.ask_side)
          json[side].map do |line|
            ActiveSupport::HashWithIndifferentAccess.new(
              broker: name.demodulize.downcase,
              side: side.singularize,
              price: BigDecimal(line['price'].to_s),
              volume: BigDecimal(line['amount'].to_s)
            )
          end
        end

        module_function :order_book, :parse
      end
    end
  end
end
