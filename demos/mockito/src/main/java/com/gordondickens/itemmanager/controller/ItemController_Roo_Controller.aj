// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.gordondickens.itemmanager.controller;

import com.gordondickens.itemmanager.entity.Item;

import java.io.UnsupportedEncodingException;
import java.lang.Long;
import java.lang.String;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect ItemController_Roo_Controller {
    
    @Autowired
    private GenericConversionService ItemController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String ItemController.create(@Valid Item item, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("item", item);
            return "item/create";
        }
        item.persist();
        return "redirect:/item/" + encodeUrlPathSegment(item.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String ItemController.createForm(Model model) {
        model.addAttribute("item", new Item());
        return "item/create";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String ItemController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("items", Item.findItemEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Item.countItems() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("items", Item.findAllItems());
        }
        return "item/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ItemController.update(@Valid Item item, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("item", item);
            return "item/update";
        }
        item.merge();
        return "redirect:/item/" + encodeUrlPathSegment(item.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String ItemController.updateForm(@PathVariable("id") Long id, Model model) {
        model.addAttribute("item", Item.findItem(id));
        return "item/update";
    }
    
    Converter<Item, String> ItemController.getItemConverter() {
        return new Converter<Item, String>() {
            public String convert(Item item) {
                return new StringBuilder().append(item.getName()).toString();
            }
        };
    }
    
    @PostConstruct
    void ItemController.registerConverters() {
        conversionService.addConverter(getItemConverter());
    }
    
    private String ItemController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
