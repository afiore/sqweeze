require '../conf/environment.rb'
require 'sqw_spec_helper.rb'

describe DOMCompiler do 
   before(:each) do 
      wget_webpage('http://www.dreamhost.com/domains.html','dom-testdir') 
      cm = ConfManager.instance
      cm.set_directories('dom-testdir','dom-testdir-build')
      @js_c=JSDOMCompiler.new
    end
  
    after(:each) do
    #  FileUtils.rm_r('dom-testdir')
    end
    
    it "(all subclasses) should look for *dom_documents* in target directory" do     
      @js_c.should have(1).dom_documents
      @js_c.dom_documents.should include('dom-testdir-build/index.html')
    end
  
    it "Should fill each script element having a src attribute with the compressed content of the javascript file therin referenciated" do 
      @js_c.compile
    
      Hpricot( open('dom-testdir-build/index.html')).search('script').each do |element|
        element.innerHTML.should_not be_empty
        element.get_attribute('src').should be_nil
      end
    end
 
    it "Should fill each link tag having a href attribute with the compressed content of the  css file therein referenced" do
      @css_c=CSSDOMCompiler.new
      @css_c.compile()
    end
    
 
 
end

#
