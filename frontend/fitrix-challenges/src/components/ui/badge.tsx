import * as React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { cn } from '@/lib/utils'

const badgeVariants = cva(
  'inline-flex items-center gap-1.5 rounded-full border px-2.5 py-1 text-[11px] font-extrabold tracking-wide',
  {
    variants: {
      variant: {
        join: 'border-volt/25 bg-volt/10 text-volt',
        full: 'border-heat/25 bg-heat/10 text-heat',
        rank: 'border-line bg-surface2 text-white',
        volt: 'border-volt bg-volt text-black',
      },
    },
    defaultVariants: { variant: 'join' },
  }
)

export interface BadgeProps extends React.HTMLAttributes<HTMLSpanElement>, VariantProps<typeof badgeVariants> {
  pulse?: boolean
}

function Badge({ className, variant, pulse, children, ...props }: BadgeProps) {
  return (
    <span className={cn(badgeVariants({ variant }), className)} {...props}>
      {pulse && variant === 'join' && (
        <span className="relative flex h-1.5 w-1.5">
          <span className="animate-volt-ping absolute inline-flex h-full w-full rounded-full bg-volt" />
          <span className="relative inline-flex rounded-full h-1.5 w-1.5 bg-volt" />
        </span>
      )}
      {children}
    </span>
  )
}

export { Badge, badgeVariants }
