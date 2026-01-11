package com.example.divineblade;

import net.minecraft.world.entity.player.Player;
import net.minecraft.world.effect.MobEffectCategory; // 导入分类
import net.neoforged.neoforge.event.entity.living.MobEffectEvent;
import net.neoforged.neoforge.event.entity.living.LivingHurtEvent;
import net.neoforged.bus.api.SubscribeEvent;

public class EventHandlers {

    @SubscribeEvent
    public static void onEffectApplicable(MobEffectEvent.Applicable event) {
        if (event.getEntity() instanceof Player player) {
            boolean holding = player.getMainHandItem().getItem() instanceof DivineBladeItem || 
                             player.getOffhandItem().getItem() instanceof DivineBladeItem;
            
            if (holding) {
                // 使用 Category 判定：HARMFUL 代表所有负面效果（如中毒、凋零、失明等）
                if (event.getEffectInstance().getEffect().getCategory() == MobEffectCategory.HARMFUL) {
                    event.setCanceled(true);
                }
            }
        }
    }

    @SubscribeEvent
    public static void onLivingHurt(LivingHurtEvent event) {
        if (event.getEntity() instanceof Player player) {
            boolean dualWield = player.getMainHandItem().getItem() instanceof DivineBladeItem && 
                               player.getOffhandItem().getItem() instanceof DivineBladeItem;

            if (dualWield) {
                // 双持锁血逻辑正确
                if (event.getAmount() > 1.0F) {
                    event.setAmount(1.0F);
                }
            }
        }
    }
}