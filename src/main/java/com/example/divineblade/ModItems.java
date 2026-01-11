package com.example.divineblade;

import net.minecraft.world.item.Item;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

public class ModItems {
    private static final DeferredRegister.Items ITEMS = DeferredRegister.createItems(DivineBladeMod.MODID);
    
    // 正确的方式：使用 DeferredItem<Item>
    public static final DeferredItem<Item> DIVINE_BLADE = ITEMS.registerItem("divine_blade",
        DivineBladeItem::new);
    
    public static void register(IEventBus eventBus) {
        ITEMS.register(eventBus);
    }
}
