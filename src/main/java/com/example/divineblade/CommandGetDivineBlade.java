package com.example.divineblade;

import com.mojang.brigadier.CommandDispatcher;
import net.minecraft.commands.CommandSourceStack;
import net.minecraft.commands.Commands;
import net.minecraft.network.chat.Component;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.enchantments.Enchantments;

public class CommandGetDivineBlade {
    public static void register(CommandDispatcher<CommandSourceStack> dispatcher) {
        dispatcher.register(Commands.literal("getdivineblade")
                .requires(src -> src.hasPermission(2)) // 需要OP权限
                .executes(ctx -> {
                    CommandSourceStack src = ctx.getSource();
                    Player player = src.getPlayerOrException();

                    ItemStack blade = new ItemStack(ModItems.DIVINE_BLADE.get());
                    // 自动附加 抢夺5 和 时运10
                    blade.enchant(Enchantments.MOB_LOOTING, 5);
                    blade.enchant(Enchantments.BLOCK_FORTUNE, 10);
                    
                    // 隐藏附魔文字，保持简介
                    blade.getOrCreateTag().putInt("HideFlags", 127);

                    if (!player.getInventory().add(blade)) {
                        player.drop(blade, false);
                    }

                    // 发送金色成功消息
                    src.sendSuccess(() -> Component.literal("§6[神之刃] §a已成功降临到你的背包！"), true);
                    return 1;
                }));
    }
}