package com.example.divineblade;

import net.neoforged.neoforge.common.NeoForge;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.fml.common.Mod;
import net.neoforged.fml.javafmlmod.FMLJavaModLoadingContext;
import net.neoforged.neoforge.event.RegisterCommandsEvent;
import net.neoforged.neoforge.event.BuildCreativeModeTabContentsEvent;
import net.minecraft.world.item.CreativeModeTabs;

@Mod(DivineBladeMod.MODID)
public class DivineBladeMod {
    public static final String MODID = "divineblade";

    public DivineBladeMod() {
        IEventBus modEventBus = FMLJavaModLoadingContext.get().getModEventBus();

        // 注册物品
        ModItems.ITEMS.register(modEventBus);

        // 注册创造模式物品栏内容
        modEventBus.addListener(this::addCreative);

        // 注册事件处理器 - 使用 NeoForge.EVENT_BUS
        NeoForge.EVENT_BUS.register(EventHandlers.class);
        
        // 注册命令
        NeoForge.EVENT_BUS.addListener(this::onRegisterCommands);
    }

    private void addCreative(BuildCreativeModeTabContentsEvent event) {
        if (event.getTabKey() == CreativeModeTabs.COMBAT) {
            event.accept(ModItems.DIVINE_BLADE);
        }
    }

    private void onRegisterCommands(RegisterCommandsEvent event) {
        CommandGetDivineBlade.register(event.getDispatcher());
    }
}