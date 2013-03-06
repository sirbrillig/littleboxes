def fill_in_select2(selector, options={})
  page.find(:css, "#s2id_#{selector} a").click 
  page.find(:css, ".select2-search input.select2-input").set options[:with]
  page.find(:css, ".select2-result-label").click # Choose the first result
end
