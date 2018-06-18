# frozen_string_literal: true

require 'dry/transaction/operation'

module Arbitrager
  module SpreadAnalyzers
    # Responsible for calculating available volume
    class AvailableVolume
      include Dry::Transaction::Operation

      def call(bid, ask)
        [bid[:volume], ask[:volume]].min
      end
    end
  end
end
