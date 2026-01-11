package com.example.divineblade;

import net.minecraft.world.item.Item;
import net.minecraft.world.item.Tier;
import net.minecraft.world.item.Rarity;
import net.minecraft.world.item.crafting.Ingredient;
import net.neoforged.neoforge.registries.DeferredRegister;
import net.neoforged.neoforge.registries.DeferredItem;
import net.minecraft.core.registries.Registries;
import java.util.function.Supplier;

public class ModItems {
    // NeoForge 使用 DeferredRegister.create() 而不是 DeferredRegister.createItems()
    public static final DeferredRegister<Item> ITEMS = 
            DeferredRegister.create(Registries.ITEM, DivineBladeMod.MODID);

    public static final Tier DIVINE_TIER = new Tier() {
        @Override public int getUses() { return 0; }
        @Override public float getSpeed() { return 1000f; }
        @Override public float getAttackDamageBonus() { return 10f; }
        @Override public int getLevel() { return 4; }
        @Override public int getEnchantmentValue() { return 30; }
        @Override public Ingredient getRepairIngredient() { return Ingredient.EMPTY; }
    };

    // NeoForge 使用 DeferredItem 而不是 RegistryObject
    public static final DeferredItem<Item> DIVINE_BLADE = 
            ITEMS.register("divine_blade", () -> new DivineBladeItem(
                    DIVINE_TIER, 
                    3, // 攻击伤害加成
                    -2.4f, // 攻击速度
                    new Item.Properties()
                            .rarity(Rarity.EPIC)
                            .fireResistant()
            ));
}