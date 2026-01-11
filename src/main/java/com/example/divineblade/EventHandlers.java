package com.example.divineblade;

import net.minecraft.world.entity.player.Player;
import net.neoforged.bus.api.SubscribeEvent;
import net.neoforged.neoforge.event.entity.player.PlayerEvent;

public class EventHandlers {
    @SubscribeEvent
    public void onPlayerLoggedIn(PlayerEvent.PlayerLoggedInEvent event) {
        Player player = event.getEntity();
        if (player != null) {
            player.sendSystemMessage(net.minecraft.network.chat.Component.literal("Welcome to Divine Blade Mod!"));
        }
    }
    
    @SubscribeEvent
    public void onPlayerInteract(net.neoforged.neoforge.event.entity.player.PlayerInteractEvent event) {
        // 示例：当玩家右键时检查是否持有神圣之刃
        if (event.getItemStack().getItem() == ModItems.DIVINE_BLADE.get()) {
            // 这里可以添加自定义逻辑
        }
    }
}
