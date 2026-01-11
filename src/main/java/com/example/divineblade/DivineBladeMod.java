package com.example.divineblade;

import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.common.Mod;
import net.neoforged.neoforge.common.NeoForge;

@Mod(DivineBladeMod.MODID)
public class DivineBladeMod {
    public static final String MODID = "divineblade";
    
    public DivineBladeMod(IEventBus modEventBus) {
        // 注册物品
        ModItems.register(modEventBus);
        
        // 注册事件处理器
        NeoForge.EVENT_BUS.register(new EventHandlers());
    }
}
