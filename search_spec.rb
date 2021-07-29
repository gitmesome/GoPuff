require 'rspec'
require 'watir'
require 'webdrivers'

describe "GoPuff Search Test" do
  before :each do
    @browser = Watir::Browser.start 'gopuff.com/drinks'
    Watir.default_timeout = 120
  end

  after :each do
    @browser.close
  end

  def sign_in
    sign_in = @browser.link(xpath: '//*[@id="vueroot"]/div[5]/div/div/div[2]/span/div/div[2]/p/a')
    sign_in.click
    @browser.wait_until { |b| b.title == "Gopuff - snacks, drinks, ice cream and more, delivered real fast" }
  end

  it "should not find any Whoppers but yes to Milky Way" do
    sign_in
    @browser.goto 'gopuff.com/#search'
    search_input = @browser.text_field(xpath: '//*[@id="product-search"]')
    search_input.set 'whoppers'
    search_input.click(:enter)

    sleep(2)
    #search_form.submit
    result = @browser.div(xpath: '/html/body/div[1]/div[1]/div[2]/div/div/div[2]/div/div[2]/div[1]/div')
    result.text.should eq("No results for 'whoppers'\nTry searching something else")

    @browser.goto 'gopuff.com/#search'
    search_input = @browser.text_field(xpath: '//*[@id="product-search"]')
    search_input.set 'milky way'
    search_input.click(:enter)

    result_link = @browser.link(xpath: '/html/body/div[1]/div[1]/div[2]/div/div/div[2]/div/div[1]/a')
    expect(result_link.href).not_to be_empty
  end
end
