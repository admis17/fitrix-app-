import * as DropdownPrimitive from '@radix-ui/react-dropdown-menu'
import { cn } from '@/lib/utils'

export const DropdownMenu = DropdownPrimitive.Root
export const DropdownMenuTrigger = DropdownPrimitive.Trigger
export function DropdownMenuContent(props: React.ComponentProps<typeof DropdownPrimitive.Content>) {
  return (
    <DropdownPrimitive.Portal>
      <DropdownPrimitive.Content
        sideOffset={6}
        className={cn('z-50 min-w-[160px] rounded-xl border border-line bg-surface p-1.5 shadow-card', (props as any).className)}
        {...props}
      />
    </DropdownPrimitive.Portal>
  )
}
export function DropdownMenuItem(props: React.ComponentProps<typeof DropdownPrimitive.Item>) {
  return (
    <DropdownPrimitive.Item
      className="flex cursor-pointer items-center gap-2 rounded-lg px-2.5 py-2 text-[12.5px] font-semibold text-white outline-none hover:bg-surface2"
      {...props}
    />
  )
}
