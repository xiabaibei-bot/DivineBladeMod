package com.example.divineblade;

import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResultHolder;
import net.minecraft.world.entity.Entity;
import net.minecraft.world.entity.LivingEntity;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.ItemStack;
import net.minecraft.world.item.SwordItem;
import net.minecraft.world.item.Tier;
import net.minecraft.world.level.Level;
import net.minecraft.world.phys.AABB;
import net.minecraft.world.phys.Vec3;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import java.util.List;

public class DivineBladeItem extends SwordItem {
    private static final float DIVINE_DAMAGE = 5_200_000F;
    private static final double RADIUS = 32.0D;

    public DivineBladeItem(Tier tier, int atk, float speed, Properties props) {
        super(tier, atk, speed, props);
    }

    @Override
    public boolean isFoil(ItemStack stack) {
        return true;
    }

    @Override
    public InteractionResultHolder<ItemStack> use(Level level, Player player, InteractionHand hand) {
        ItemStack stack = player.getItemInHand(hand);
        if (!level.isClientSide) {
            Vec3 center = player.position();
            AABB box = new AABB(center.subtract(RADIUS, RADIUS, RADIUS), center.add(RADIUS, RADIUS, RADIUS));
            List<LivingEntity> targets = level.getEntitiesOfClass(LivingEntity.class, box,
                e -> e != player && e.distanceToSqr(player) <= RADIUS * RADIUS);
            for (LivingEntity target : targets) {
                target.hurt(level.damageSources().playerAttack(player), DIVINE_DAMAGE);
            }
        }
        return InteractionResultHolder.success(stack);
    }

    @Override
    public boolean hurtEnemy(ItemStack stack, LivingEntity target, LivingEntity attacker) {
        if (attacker instanceof Player player && !attacker.level().isClientSide) {
            target.hurt(attacker.level().damageSources().playerAttack(player), DIVINE_DAMAGE);
        }
        return true;
    }

    @Override
    public void inventoryTick(ItemStack stack, Level level, Entity entity, int slot, boolean selected) {
        if (!(entity instanceof Player player) || level.isClientSide) return;
        boolean isHolding = player.getMainHandItem() == stack || player.getOffhandItem() == stack;
        if (isHolding) {
            player.addEffect(new MobEffectInstance(MobEffects.ABSORPTION, 20, 3, false, false));
            player.addEffect(new MobEffectInstance(MobEffects.NIGHT_VISION, 220, 0, false, false));
            player.getActiveEffects().stream()
                .filter(i -> i.getEffect().isBeneficial() == false)
                .map(MobEffectInstance::getEffect)
                .forEach(player::removeEffect);
            if (!player.getAbilities().mayfly) {
                player.getAbilities().mayfly = true;
                if (player instanceof ServerPlayer sp) sp.onUpdateAbilities();
            }
            if (stack.hasTag()) { 
                stack.getOrCreateTag().putInt("HideFlags", 127); 
            }
        } else if (player.getAbilities().mayfly && !player.isCreative() && !player.isSpectator()) {
            player.getAbilities().mayfly = false;
            player.getAbilities().flying = false;
            if (player instanceof ServerPlayer sp) sp.onUpdateAbilities();
        }
    }

    @Override
    public float getDestroySpeed(ItemStack stack, net.minecraft.world.level.block.state.BlockState state) { 
        return 1000f; 
    }
    
    @Override
    public boolean isCorrectToolForDrops(ItemStack stack, net.minecraft.world.level.block.state.BlockState state) { 
        return true; 
    }
}
