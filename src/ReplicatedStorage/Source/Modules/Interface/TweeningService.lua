-- For all easing functions:
-- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)

local TweenService = { }

local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin	= math.asin
local RunService = game:GetService("RunService")

function TweenService.Linear(t, b, c, d)
    return c * t / d + b
end

function TweenService.InQuad(t, b, c, d)
    t = t / d
    return c * pow(t, 2) + b
end

function TweenService.OutQuad(t, b, c, d)
    t = t / d
    return -c * t * (t - 2) + b
end

function TweenService.InOutQuad(t, b, c, d)
    t = t / d * 2
    if t < 1 then
        return c / 2 * pow(t, 2) + b
    else
        return -c / 2 * ((t - 1) * (t - 3) - 1) + b
    end
end

function TweenService.OutInQuad(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutQuad (t * 2, b, c / 2, d)
    else
        return TweenService.InQuad((t * 2) - d, b + c / 2, c / 2, d)
    end
end

function TweenService.InCubic (t, b, c, d)
    t = t / d
    return c * pow(t, 3) + b
end

function TweenService.OutCubic(t, b, c, d)
    t = t / d - 1
    return c * (pow(t, 3) + 1) + b
end

function TweenService.InOutCubic(t, b, c, d)
    t = t / d * 2
    if t < 1 then
        return c / 2 * t * t * t + b
    else
        t = t - 2
        return c / 2 * (t * t * t + 2) + b
    end
end

function TweenService.OutInCubic(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutCubic(t * 2, b, c / 2, d)
    else
        return TweenService.InCubic((t * 2) - d, b + c / 2, c / 2, d)
    end
end

function TweenService.InQuart(t, b, c, d)
    t = t / d
    return c * pow(t, 4) + b
end

function TweenService.OutQuart(t, b, c, d)
    t = t / d - 1
    return -c * (pow(t, 4) - 1) + b
end

function TweenService.InOutQuart(t, b, c, d)
    t = t / d * 2
    if t < 1 then
        return c / 2 * pow(t, 4) + b
    else
        t = t - 2
        return -c / 2 * (pow(t, 4) - 2) + b
    end
end

function TweenService.OutInQuart(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutQuart(t * 2, b, c / 2, d)
    else
        return TweenService.InQuart((t * 2) - d, b + c / 2, c / 2, d)
    end
end

function TweenService.InQuint(t, b, c, d)
    t = t / d
    return c * pow(t, 5) + b
end

function TweenService.OutQuint(t, b, c, d)
    t = t / d - 1
    return c * (pow(t, 5) + 1) + b
end

function TweenService.InOutQuint(t, b, c, d)
    t = t / d * 2
    if t < 1 then
        return c / 2 * pow(t, 5) + b
    else
        t = t - 2
        return c / 2 * (pow(t, 5) + 2) + b
    end
end

function TweenService.OutInQuint(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutQuint(t * 2, b, c / 2, d)
    else
        return TweenService.InQuint((t * 2) - d, b + c / 2, c / 2, d)
    end
end

function TweenService.InSine(t, b, c, d)
    return -c * cos(t / d * (pi / 2)) + c + b
end

function TweenService.OutSine(t, b, c, d)
    return c * sin(t / d * (pi / 2)) + b
end

function TweenService.InOutSine(t, b, c, d)
    return -c / 2 * (cos(pi * t / d) - 1) + b
end

function TweenService.OutInSine(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutSine(t * 2, b, c / 2, d)
    else
        return TweenService.InSine((t * 2) -d, b + c / 2, c / 2, d)
    end
end

function TweenService.InExpo(t, b, c, d)
    if t == 0 then
        return b
    else
        return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
    end
end

function TweenService.OutExpo(t, b, c, d)
    if t == d then
        return b + c
    else
        return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
    end
end

function TweenService.InOutExpo(t, b, c, d)
    if t == 0 then return b end
    if t == d then return b + c end
    t = t / d * 2
    if t < 1 then
        return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
    else
        t = t - 1
        return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
    end
end

function TweenService.OutInExpo(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutExpo(t * 2, b, c / 2, d)
    else
        return TweenService.InExpo((t * 2) - d, b + c / 2, c / 2, d)
    end
end

function TweenService.InCirc(t, b, c, d)
    t = t / d
    return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

function TweenService.OutCirc(t, b, c, d)
    t = t / d - 1
    return(c * sqrt(1 - pow(t, 2)) + b)
end

function TweenService.InOutCirc(t, b, c, d)
    t = t / d * 2
    if t < 1 then
        return -c / 2 * (sqrt(1 - t * t) - 1) + b
    else
        t = t - 2
        return c / 2 * (sqrt(1 - t * t) + 1) + b
    end
end

function TweenService.OutInCirc(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutCirc(t * 2, b, c / 2, d)
    else
        return TweenService.InCirc((t * 2) - d, b + c / 2, c / 2, d)
    end
end

-- a: aplitude
-- p: period
function TweenService.InElastic(t, b, c, d, a, p)
    if t == 0 then return b end

    t = t / d

    if t == 1  then return b + c end

    if not p then p = d * 0.3 end

    local s

    if not a or a < abs(c) then
        a = c
        s = p / 4
    else
        s = p / (2 * pi) * asin(c/a)
    end

    t = t - 1

    return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitude
-- p: period
function TweenService.OutElastic(t, b, c, d, a, p)
    if t == 0 then return b end

    t = t / d

    if t == 1 then return b + c end

    if not p then p = d * 0.3 end

    local s

    if not a or a < abs(c) then
        a = c
        s = p / 4
    else
        s = p / (2 * pi) * asin(c/a)
    end

    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

-- a: amplitude
-- p: period
function TweenService.InOutElastic(t, b, c, d, a, p)
    if t == 0 then return b end

    t = t / d * 2

    if t == 2 then return b + c end

    if not p then p = d * (0.3 * 1.5) end
    if not a then a = 0 end

    local s

    if not a or a < abs(c) then
        a = c
        s = p / 4
    else
        s = p / (2 * pi) * asin(c / a)
    end

    if t < 1 then
        t = t - 1
        return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
    else
        t = t - 1
        return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
    end
end

-- a: amplitude
-- p: period
function TweenService.OutInElastic(t, b, c, d, a, p)
    if t < d / 2 then
        return TweenService.OutElastic(t * 2, b, c / 2, d, a, p)
    else
        return TweenService.InElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
    end
end

function TweenService.InBack(t, b, c, d, s)
    if not s then s = 1.70158 end
    t = t / d
    return c * t * t * ((s + 1) * t - s) + b
end

function TweenService.OutBack(t, b, c, d, s)
    if not s then s = 1.70158 end
    t = t / d - 1
    return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function TweenService.InOutBack(t, b, c, d, s)
    if not s then s = 1.70158 end
    s = s * 1.525
    t = t / d * 2
    if t < 1 then
        return c / 2 * (t * t * ((s + 1) * t - s)) + b
    else
        t = t - 2
        return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
    end
end

function TweenService.OutInBack(t, b, c, d, s)
    if t < d / 2 then
        return TweenService.OutBack(t * 2, b, c / 2, d, s)
    else
        return TweenService.InBack((t * 2) - d, b + c / 2, c / 2, d, s)
    end
end

function TweenService.OutBounce(t, b, c, d)
    t = t / d
    if t < 1 / 2.75 then
        return c * (7.5625 * t * t) + b
    elseif t < 2 / 2.75 then
        t = t - (1.5 / 2.75)
        return c * (7.5625 * t * t + 0.75) + b
    elseif t < 2.5 / 2.75 then
        t = t - (2.25 / 2.75)
        return c * (7.5625 * t * t + 0.9375) + b
    else
        t = t - (2.625 / 2.75)
        return c * (7.5625 * t * t + 0.984375) + b
    end
end

function TweenService.InBounce(t, b, c, d)
    return c - TweenService.OutBounce(d - t, 0, c, d) + b
end

function TweenService.InOutBounce(t, b, c, d)
    if t < d / 2 then
        return TweenService.InBounce(t * 2, 0, c, d) * 0.5 + b
    else
        return TweenService.OutBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
    end
end

function TweenService.OutInBounce(t, b, c, d)
    if t < d / 2 then
        return TweenService.OutBounce(t * 2, b, c / 2, d)
    else
        return TweenService.InBounce((t * 2) - d, b + c / 2, c / 2, d)
    end
end

function TweenService.Tween(guiElement, easingMethod, endProperties, duration) --// Instance GuiElement, String EastingDirectionAndStyle, Dictionary PropertyGoals, float duration
	assert(guiElement:GetFullName():match("%a+.-$"), "GuiElement must be a child of the data model")
	local t = 0;
	for prop, goal in next, endProperties do
		local start = guiElement[prop]

		if (typeof(goal))=="UDim2" then
			coroutine.resume(coroutine.create(function()
				while (t<duration) do
					guiElement[prop] = UDim2.new(
						TweenService[easingMethod](t, start.X.Scale, goal.X.Scale-start.X.Scale, duration),
						TweenService[easingMethod](t, start.X.Offset, goal.X.Offset-start.X.Offset, duration),
						TweenService[easingMethod](t, start.Y.Scale, goal.Y.Scale-start.Y.Scale, duration),
						TweenService[easingMethod](t, start.Y.Offset, goal.Y.Offset-start.Y.Offset, duration)
					)
					t = t + RunService.RenderStepped:wait()
				end
				t = duration
				guiElement[prop] = UDim2.new(
					TweenService[easingMethod](t, start.X.Scale, goal.X.Scale-start.X.Scale, duration),
					TweenService[easingMethod](t, start.X.Offset, goal.X.Offset-start.X.Offset, duration),
					TweenService[easingMethod](t, start.Y.Scale, goal.Y.Scale-start.Y.Scale, duration),
					TweenService[easingMethod](t, start.Y.Offset, goal.Y.Offset-start.Y.Offset, duration)
				)
			end))
					
		elseif (typeof(goal))=="Color3" then
			coroutine.resume(coroutine.create(function()
				while (t<duration) do
					print("shifting colour")
					guiElement[prop] = Color3.new(
						TweenService[easingMethod](t, start.r, goal.r-start.r, duration),
						TweenService[easingMethod](t, start.g, goal.g-start.g, duration),
						TweenService[easingMethod](t, start.b, goal.b-start.b, duration)
					)
					t = t + RunService.RenderStepped:wait()
				end
				t = duration
				guiElement[prop] = Color3.new(
					TweenService[easingMethod](t, start.r, goal.r-start.r, duration),
					TweenService[easingMethod](t, start.g, goal.g-start.g, duration),
					TweenService[easingMethod](t, start.b, goal.b-start.b, duration)
				)
			end))
			
		elseif (typeof(goal))=="number" then
			coroutine.resume(coroutine.create(function()
				local b = guiElement[prop]
				local c = goal - b
				local d = duration
				while (t<duration) do
					guiElement[prop] = TweenService[easingMethod](t, b, c, d)
					t = t + RunService.RenderStepped:wait()
				end
				t=duration
				guiElement[prop] = TweenService[easingMethod](t, b, c, d)
			end))
		end
		
	end
end

return TweenService;