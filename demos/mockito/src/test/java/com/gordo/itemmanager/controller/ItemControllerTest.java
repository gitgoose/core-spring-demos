package com.gordo.itemmanager.controller;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertSame;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.springframework.ui.ModelMap;

import com.gordo.itemmanager.entity.Item;
import com.gordo.itemmanager.exception.ItemNotFoundException;
import com.gordo.itemmanager.service.internal.ItemService;

//NOTE: Do NOT annotate with Context Configuration - we are mocking seams (layer boundaries)
@RunWith(MockitoJUnitRunner.class)
public class ItemControllerTest {
	private ItemController itemController;

	@Mock
	private ItemService itemService;
	private ModelMap modelMap;

	@Before
	public void setUp() {
		itemController = new ItemController(itemService);
		modelMap = new ModelMap();
	}

	@Test
	public void testViewItem() throws Exception {
		Item item = new Item();
		item.setId(1l);
		item.setName("Item 1");
		when(itemService.getItem(item.getId())).thenReturn(item);

		String view = itemController.show(item.getId(), modelMap);

		assertEquals(item, modelMap.get("item"));
		assertEquals("item/show", view);
	}

	@Test
	public void testViewItemWithItemNotFoundException() throws Exception {
		ItemNotFoundException exception = new ItemNotFoundException(5);
		when(itemService.getItem(5l)).thenThrow(exception);

		String view = itemController.show(5l, modelMap);

		assertEquals("redirect:/errorView", view);
		assertSame(exception, modelMap.get("exception"));
	}

	@Test
	public void testDeleteItem() throws Exception {
		String view = itemController.delete(5l, null, null);

		verify(itemService).deleteItem(15l);
		assertTrue(view.startsWith("redirect:/item?page="));
	}

}