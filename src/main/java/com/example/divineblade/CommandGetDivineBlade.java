package com.example.divineblade;

import com.mojang.brigadier.CommandDispatcher;
import net.minecraft.commands.CommandSourceStack;
import net.minecraft.commands.Commands;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.enchantment.EnchantmentHelper;
import net.minecraft.world.item.enchantment.Enchantments;
import java.util.Map;

public class CommandGetDivineBlade {
    public static void register(CommandDispatcher<CommandSourceStack> dispatcher) {
        dispatcher.register(Commands.literal("divineblade")
            .requires(source -> source.hasPermission(2))
            .executes(context -> {
                CommandSourceStack source = context.getSource();
                ServerPlayer player = source.getPlayerOrException();
                
                // 给玩家神圣之刃
                ItemStack divineBlade = new ItemStack(ModItems.DIVINE_BLADE.get());
                
                // 使用正确的方式添加附魔
                Map<net.minecraft.world.item.enchantment.Enchantment, Integer> enchantments = 
                    Map.of(
                        Enchantments.MOB_LOOTING, 5,
                        Enchantments.BLOCK_FORTUNE, 10
                    );
                EnchantmentHelper.setEnchantments(enchantments, divineBlade);
                
                // 给玩家物品
                if (!player.getInventory().add(divineBlade)) {
                    player.drop(divineBlade, false);
                }
                
                return 1;
            })
        );
    }
}
