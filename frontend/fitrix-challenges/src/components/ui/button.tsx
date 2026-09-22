import * as React from 'react'
import { Slot } from '@radix-ui/react-slot'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from '@/lib/utils'

const buttonVariants = cva(
  'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-[13px] font-bold transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-volt/60 disabled:pointer-events-none disabled:opacity-50 active:scale-[.97]',
  {
    variants: {
      variant: {
        primary: 'bg-volt text-black hover:brightness-110 shadow-voltglow',
        outline: 'border border-line bg-surface text-white hover:bg-surface2 hover:border-[#3A4047]',
        ghost: 'text-muted2 hover:text-white hover:bg-surface2',
        destructive: 'bg-heat/15 text-heat border border-heat/25',
      },
      size: {
        default: 'h-11 px-4',
        sm: 'h-9 px-3',
        icon: 'h-10 w-10',
      },
    },
    defaultVariants: { variant: 'primary', size: 'default' },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : 'button'
    return <Comp className={cn(buttonVariants({ variant, size, className }))} ref={ref} {...props} />
  }
)
Button.displayName = 'Button'

export { Button, buttonVariants }
