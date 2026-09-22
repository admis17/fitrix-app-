import { useEffect, useMemo, useState } from 'react'
import { HashRouter, Routes, Route, Link } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import {
  Search, Wallet, Trophy, Home, Flame, User, Zap, Flower2, Bike,
  Play, Clock, Plus, History, BadgeIndianRupee, MoreVertical, Share2, Info, CheckCircle2, X,
} from 'lucide-react'
import { Card } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Avatar, AvatarFallback } from '@/components/ui/avatar'
import { Skeleton } from '@/components/ui/skeleton'
import { TooltipProvider, Tooltip, TooltipTrigger, TooltipContent } from '@/components/ui/tooltip'
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from '@/components/ui/dropdown'
import { challenges, leaderboard, rankStyles } from '@/data'
import { cn } from '@/lib/utils'
import ParticipatePage from '@/pages/ParticipatePage'
import AddChallengePage from '@/pages/AddChallengePage'
import HistoryPage from '@/pages/HistoryPage'
import AddPrizePage from '@/pages/AddPrizePage'

const fadeUp = {
  hidden: { opacity: 0, y: 14 },
  show: (i: number = 0) => ({
    opacity: 1,
    y: 0,
    transition: { delay: 0.05 * i, duration: 0.35, ease: [0.22, 1, 0.36, 1] as const },
  }),
}

function ChallengeIcon({ icon }: { icon: string }) {
  const cls = 'h-[18px] w-[18px]'
  if (icon === 'zap') return <Zap className={cls} />
  if (icon === 'yoga') return <Flower2 className={cls} />
  return <Bike className={cls} />
}

const tabs = [
  { id: 'home', label: 'Home', icon: Home },
  { id: 'challenges', label: 'Challenges', icon: Trophy },
  { id: 'streaks', label: 'Streaks', icon: Flame },
  { id: 'wallet', label: 'Wallet', icon: Wallet },
  { id: 'profile', label: 'Profile', icon: User },
]

function ChallengesHome() {
  const [query, setQuery] = useState('')
  const [loading, setLoading] = useState(true)
  const [activeTab, setActiveTab] = useState('challenges')
  const [joined, setJoined] = useState<string[]>([])

  useEffect(() => {
    const t = setTimeout(() => setLoading(false), 900)
    return () => clearTimeout(t)
  }, [])

  const filtered = useMemo(() => {
    const q = query.trim().toLowerCase()
    if (!q) return challenges
    return challenges.filter((c) =>
      `${c.title} ${c.coach} ${c.category} ${c.time}`.toLowerCase().includes(q)
    )
  }, [query])

  return (
    <div className="min-h-full bg-ink text-white">
      <header className="sticky top-0 z-30 border-b border-line bg-ink/80 backdrop-blur-xl">
        <div className="mx-auto flex max-w-[680px] items-center gap-3 px-4 py-3">
          <div className="flex shrink-0 items-center gap-2">
            <div className="grid h-8 w-8 place-items-center rounded-[10px] bg-volt text-[15px] font-black text-black">F</div>
            <div className="text-[19px] font-black tracking-tight">FIT<span className="text-volt">RIX</span></div>
          </div>
          <div className="relative mx-auto w-full max-w-[420px] flex-1">
            <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted2" />
            <input
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search challenges"
              className="h-10 w-full rounded-xl border border-line bg-surface pl-9 pr-8 text-[13px] outline-none placeholder:text-muted2 focus:border-volt/50 focus:bg-surface2"
            />
            {query && (
              <button onClick={() => setQuery('')} className="absolute right-2 top-1/2 -translate-y-1/2 rounded-full p-1 text-muted2 hover:text-white">
                <X size={14} />
              </button>
            )}
          </div>
          <div className="flex shrink-0 items-center gap-2">
            <Tooltip>
              <TooltipTrigger asChild>
                <motion.button whileTap={{ scale: 0.9 }} className="relative grid h-9 w-9 place-items-center rounded-full border border-line bg-surface hover:bg-surface2">
                  <Wallet size={16} />
                  <span className="absolute -right-0.5 -top-0.5 h-2.5 w-2.5 rounded-full border-2 border-ink bg-volt" />
                </motion.button>
              </TooltipTrigger>
              <TooltipContent>2,140 pts · ₹214 rewards</TooltipContent>
            </Tooltip>
            <Tooltip>
              <TooltipTrigger asChild>
                <motion.div whileTap={{ scale: 0.92 }} className="grid h-9 w-9 cursor-pointer place-items-center rounded-full bg-gradient-to-br from-volt to-[#8BC500] text-[12px] font-extrabold text-black">JM</motion.div>
              </TooltipTrigger>
              <TooltipContent>Jordan Miles · Profile</TooltipContent>
            </Tooltip>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-[680px] px-4 pb-28 pt-5">
        <motion.div variants={fadeUp} initial="hidden" animate="show">
          <h1 className="text-[26px] font-black leading-none tracking-tight">Challenges</h1>
          <p className="mt-1.5 text-[12.5px] text-muted2">Today • 3 active • 12 Sept</p>
        </motion.div>

        <div className="mb-2.5 mt-6 flex items-center justify-between">
          <h2 className="text-[11px] font-bold uppercase tracking-[.08em] text-muted2">Today challenges</h2>
          <span className="text-[11px] font-semibold text-muted2">{filtered.length} of {challenges.length}</span>
        </div>

        {loading ? (
          <div className="space-y-2.5">
            {[0, 1, 2].map((i) => <Skeleton key={i} className="h-[72px] w-full" />)}
          </div>
        ) : (
          <motion.div initial="hidden" animate="show" className="space-y-2.5">
            <AnimatePresence>
              {filtered.map((c, i) => (
                <motion.div key={c.id} custom={i} variants={fadeUp} layout exit={{ opacity: 0, scale: 0.97 }}>
                  <motion.div whileHover={{ scale: 1.01 }} whileTap={{ scale: 0.98 }}>
                    <Card className="flex items-center gap-3 p-3.5 transition-colors hover:border-[#3A4047]">
                      <div className="grid h-10 w-10 shrink-0 place-items-center rounded-xl border border-line bg-surface2">
                        <ChallengeIcon icon={c.icon} />
                      </div>
                      <div className="min-w-0 flex-1">
                        <div className="truncate text-[13.5px] font-bold">{c.title}</div>
                        <div className="mt-0.5 flex items-center gap-1 truncate text-[12px] text-muted2">
                          <Clock size={12} /> {c.time} · {c.coach} · {c.category}
                        </div>
                      </div>
                      {c.status === 'join' ? (
                        <Tooltip>
                          <TooltipTrigger asChild>
                            <span>
                              <Badge
                                variant="join"
                                pulse
                                className="cursor-pointer"
                                onClick={() => setJoined((j) => (j.includes(c.id) ? j.filter((x) => x !== c.id) : [...j, c.id]))}
                              >
                                {joined.includes(c.id) ? <><CheckCircle2 size={12} /> Joined</> : '● Join'}
                              </Badge>
                            </span>
                          </TooltipTrigger>
                          <TooltipContent>{joined.includes(c.id) ? 'Tap to leave' : 'Tap to join · live now'}</TooltipContent>
                        </Tooltip>
                      ) : (
                        <Badge variant="full">✕ Full</Badge>
                      )}
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <button className="rounded-lg p-1.5 text-muted2 hover:bg-surface2 hover:text-white">
                            <MoreVertical size={15} />
                          </button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem><Info size={14} /> Details</DropdownMenuItem>
                          <DropdownMenuItem><Share2 size={14} /> Share</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </Card>
                  </motion.div>
                </motion.div>
              ))}
            </AnimatePresence>
            {filtered.length === 0 && (
              <Card className="p-6 text-center text-[13px] text-muted2">No challenges for “{query}”. Try “HIIT” or “Yoga”.</Card>
            )}
          </motion.div>
        )}

        <h2 className="mb-2.5 mt-6 text-[11px] font-bold uppercase tracking-[.08em] text-muted2">Challenger spotlight</h2>
        {loading ? <Skeleton className="h-[240px] w-full" /> : (
          <motion.div variants={fadeUp} initial="hidden" animate="show" custom={1}>
            <motion.div whileHover={{ scale: 1.005 }} whileTap={{ scale: 0.99 }}>
              <Card className="overflow-hidden p-0">
                <div className="relative h-[168px] overflow-hidden">
                  <img
                    src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=1000&q=70&auto=format&fit=crop"
                    alt="Challenger training"
                    loading="lazy"
                    className="h-full w-full object-cover"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/15 to-transparent" />
                  <div className="absolute inset-0 bg-volt/5 mix-blend-overlay" />
                  <motion.button
                    whileHover={{ scale: 1.08 }}
                    whileTap={{ scale: 0.9 }}
                    aria-label="Play challenger video"
                    className="absolute left-1/2 top-1/2 grid h-[54px] w-[54px] -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-white/30 bg-white/15 shadow-card backdrop-blur-xl"
                  >
                    <Play size={22} className="ml-0.5 fill-white text-white" />
                  </motion.button>
                  <div className="absolute inset-x-2.5 bottom-2.5 flex items-center justify-between">
                    <span className="rounded-lg border border-white/15 bg-black/55 px-2 py-1 text-[10.5px] font-bold backdrop-blur-md">▶ 30s preview</span>
                    <span className="rounded-md bg-black/65 px-1.5 py-1 text-[10.5px] font-semibold">0:30</span>
                  </div>
                </div>
                <div className="p-3.5">
                  <div className="text-[13px] font-bold">Challenger intro — September Sweat</div>
                  <div className="mt-0.5 text-[12px] text-muted2">Top form this week • Tap to watch full</div>
                </div>
              </Card>
            </motion.div>
          </motion.div>
        )}

        <h2 className="mb-2.5 mt-6 text-[11px] font-bold uppercase tracking-[.08em] text-muted2">Leaderboard</h2>
        {loading ? <Skeleton className="h-[168px] w-full" /> : (
          <Card className="p-2">
            <motion.div layout className="divide-y divide-line">
              {leaderboard.map((p, i) => (
                <motion.div
                  key={p.name}
                  layout
                  custom={i}
                  variants={fadeUp}
                  initial="hidden"
                  animate="show"
                  transition={{ type: 'spring', stiffness: 350, damping: 30 }}
                  className={cn(
                    'flex items-center gap-2.5 px-2.5 py-2.5',
                    p.self && 'm-1 rounded-xl border border-volt/20 bg-volt/[.07] px-2.5'
                  )}
                >
                  <span className={cn('grid h-[26px] w-[26px] shrink-0 place-items-center rounded-full text-[11px] font-black', rankStyles[p.rank])}>
                    {p.rank}
                  </span>
                  <Avatar className="h-[30px] w-[30px]">
                    <AvatarFallback className={cn(p.self ? 'bg-volt text-black' : p.rank === 1 ? 'bg-gradient-to-br from-[#8BC500] to-volt text-black' : '')}>
                      {p.initials}
                    </AvatarFallback>
                  </Avatar>
                  <span className={cn('flex-1 truncate text-[13px]', p.self ? 'font-bold' : 'font-semibold')}>
                    {p.name}
                    {p.self && <span className="ml-1.5 rounded-full bg-volt px-1.5 py-0.5 align-middle text-[9px] font-extrabold text-black">YOU</span>}
                  </span>
                  <span className="text-[11.5px] text-muted2">{p.attempts} · <b className="text-volt">{p.pts} pts</b></span>
                </motion.div>
              ))}
            </motion.div>
          </Card>
        )}

        <h2 className="mb-2.5 mt-6 text-[11px] font-bold uppercase tracking-[.08em] text-muted2">Prize pool</h2>
        {loading ? <Skeleton className="h-[84px] w-full" /> : (
          <motion.div variants={fadeUp} initial="hidden" animate="show" custom={3} whileHover={{ scale: 1.01 }} whileTap={{ scale: 0.99 }}>
            <div className="rounded-2xl bg-gradient-to-br from-volt/50 via-volt/10 to-transparent p-[1.5px] shadow-voltglow">
              <div className="flex items-center justify-between rounded-2xl bg-surface px-4 py-3.5">
                <div className="flex items-center gap-3">
                  <div className="grid h-[42px] w-[42px] place-items-center rounded-xl border border-volt/25 bg-volt/10 text-volt">
                    <Trophy size={20} />
                  </div>
                  <div>
                    <div className="text-[10px] font-bold uppercase tracking-[.08em] text-muted2">Total pool</div>
                    <div className="text-[11px] text-muted2">Set by gym &amp; participants</div>
                  </div>
                </div>
                <div className="text-[24px] font-black tracking-tight text-volt">₹5,000</div>
              </div>
            </div>
          </motion.div>
        )}

        {/* ACTIONS → separate pages linked to Challenges only */}
        <div className="mt-6 grid grid-cols-2 gap-2">
          <Link to="/participate"><Button variant="primary" className="w-full"><CheckCircle2 size={15} /> Participate</Button></Link>
          <Link to="/add-challenge"><Button variant="outline" className="w-full"><Plus size={15} /> Add challenge</Button></Link>
          <Link to="/history"><Button variant="outline" className="w-full"><History size={15} /> History</Button></Link>
          <Link to="/add-prize"><Button variant="outline" className="w-full"><BadgeIndianRupee size={15} /> Add prize</Button></Link>
        </div>
      </main>

      <nav className="fixed inset-x-0 bottom-0 z-30 border-t border-line bg-ink/95 backdrop-blur-xl">
        <div className="mx-auto grid max-w-[680px] grid-cols-5 px-2 pb-3.5 pt-2">
          {tabs.map((t) => {
            const active = t.id === activeTab
            const Icon = t.icon
            return (
              <button
                key={t.id}
                onClick={() => setActiveTab(t.id)}
                className={cn('relative flex flex-col items-center gap-0.5 rounded-xl py-1.5 text-[10px] font-bold', active ? 'text-volt' : 'text-muted2')}
              >
                {active && (
                  <motion.span
                    layoutId="nav-pill"
                    className="absolute inset-x-3 inset-y-0 rounded-xl bg-volt/10"
                    transition={{ type: 'spring', stiffness: 500, damping: 35 }}
                  />
                )}
                <Icon size={19} className="relative" />
                <span className="relative">{t.label}</span>
                {active && <motion.span layoutId="nav-dot" className="relative h-1 w-1 rounded-full bg-volt" />}
              </button>
            )
          })}
        </div>
      </nav>
    </div>
  )
}

export default function App() {
  return (
    <TooltipProvider>
      <HashRouter>
        <Routes>
          <Route path="/" element={<ChallengesHome />} />
          <Route path="/participate" element={<ParticipatePage />} />
          <Route path="/add-challenge" element={<AddChallengePage />} />
          <Route path="/history" element={<HistoryPage />} />
          <Route path="/add-prize" element={<AddPrizePage />} />
          <Route path="*" element={<ChallengesHome />} />
        </Routes>
      </HashRouter>
    </TooltipProvider>
  )
}
