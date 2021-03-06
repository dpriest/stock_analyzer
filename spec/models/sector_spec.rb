require 'spec_helper'

describe Sector do
  let(:sector) { Factory.build(:sector) }
  subject { sector }

  [:pe_ratio, :ev_to_sales, :ev_to_ebitda, :roe, :roce, :debt_to_equity_ratio, :price_to_book_value, :peg_ratio, :operating_cash_to_sales].each do |formula|
    it("should calculate #{formula}") {
      Factory.build(:company).tap { |company| company.stub_method(formula => 25); sector.companies << company }
      Factory.build(:company).tap { |company| company.stub_method(formula => 20); sector.companies << company }
      Factory.build(:company).tap { |company| company.stub_method(formula => 22); sector.companies << company }
      Factory.build(:company).tap { |company| company.stub_method(formula => 10); sector.companies << company }
      sector.send(formula).should == 21
    }
  end
end
