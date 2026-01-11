package com.example.divineblade;

import net.minecraft.world.item.Item;
import net.minecraft.world.item.Rarity;
import net.minecraft.world.item.ItemStack;

public class DivineBladeItem extends Item {
    public DivineBladeItem() {
        super(new Properties()
            .stacksTo(1)
            .rarity(Rarity.EPIC)
            .fireResistant()
        );
    }
    
    @Override
    public boolean isFoil(ItemStack stack) {
        return true; // 让物品有附魔光效
    }
}
