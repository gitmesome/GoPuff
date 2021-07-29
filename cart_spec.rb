require 'rspec'
require 'watir'
require 'webdrivers'

describe "GoPuff Cart Test" do
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

  it "should add then delete an item from the cart" do
    sign_in
    @browser.goto 'gopuff.com/drinks'

    soda_link = @browser.link(href: '/drinks/soda')
    expect(soda_link.text).to eq("Soda")
    soda_link.click

    dew_div = @browser.div(xpath: '/html/body/div[1]/div[1]/div[2]/div/div/div[2]/div[2]/div[1]/a[1]/div[3]/div[3]')
    expect(dew_div.text).to eq("Add")
    dew_div.click

    my_bag = @browser.button(xpath: '//*[@id="vueroot"]/div[1]/div[1]/div[1]/div[1]/div[3]/div/button')
    expect(my_bag.text).to eq("My Bag")

    bag_count = @browser.div(xpath: '//*[@id="vueroot"]/div[1]/div[1]/div[1]/div[1]/div[3]/div/div')
    expect(bag_count.text).to eq("1")
    my_bag.click

    sleep(2) # allow bag to load
    product_span = @browser.span(xpath: '//*[@id="vueroot"]/div[2]/div/div/div[2]/div/div[1]/div/div[1]/div[2]/div[2]/span')
    expect(product_span.text).to eq("1 product")

    details_span = @browser.span(xpath: '//*[@id="vueroot"]/div[2]/div/div/div[2]/div/div[1]/div/div[1]/div[2]/div[1]/span[2]')
    details_span.click

    delete_img = @browser.img(xpath: '//*[@id="vueroot"]/div[2]/div/div/div[2]/div/div[1]/div/div[1]/div[3]/div/div[4]/img')
    delete_img.click

    sleep(5)
    empty_bag = @browser.div(xpath: '//*[@id="vueroot"]/div[2]/div/div/div[2]/div/div[1]/div[1]/div/div/div[1]')
    expect(empty_bag.text).to eq("Your Bag is Empty")
  end
end
